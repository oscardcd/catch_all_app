import 'package:catch_all_app/domain/services/auth_service.dart';
import 'package:catch_all_app/data/endpoints/endpoints.dart';
import 'package:catch_all_app/domain/models/user_model.dart';
import 'package:client_api/client_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServiceImpl implements AuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthServiceImpl({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      _googleSignIn = googleSignIn ?? GoogleSignIn.instance;

  Future<(User, String)> _authenticateWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.idToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    final user = userCredential.user;

    if (user == null) {
      throw Exception('Failed to sign in to Firebase: User is null');
    }

    return (user, googleAuth.idToken ?? '');
  }

  @override
  Future<ApiResult<UserModel>> signInWithGoogle() async {
    try {
      final (user, idToken) = await _authenticateWithGoogle();

      // Use ApiClient to perform login/register call in our own backend
      return await ApiClient.instance.request(
        ApiRequest.post(
          AuthEndpoints.login,
          body: {
            'token': idToken,
            'email': user.email,
            'uid': user.uid,
            'displayName': user.displayName,
            'photoUrl': user.photoURL,
          },
        ),
        (json) => UserModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      return ApiResult.failure(error: e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<ApiResult<UserModel>> signInWithFirebase() async {
    try {
      final (user, _) = await _authenticateWithGoogle();

      return ApiResult.success(
        data: UserModel(id: user.uid, email: user.email, displayName: user.displayName, photoUrl: user.photoURL),
      );
    } catch (e) {
      return ApiResult.failure(error: e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<ApiResult<UserModel>> signInWithEmailAndPassword(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate a little delay

    if (email.contains('testDev') && password.contains('c4tch-All-App')) {
      return ApiResult.success(
        data: const UserModel(
          id: 'mock-local-uid',
          email: 'testDev@catchall.com',
          displayName: 'test dev',
          photoUrl: 'https://i.pravatar.cc/150?u=testDev',
        ),
      );
    } else {
      return ApiResult.failure(error: Exception('Credenciales locales inválidas'));
    }
  }

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
