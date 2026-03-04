import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:catch_all_app/domain/repositories/auth_repository.dart';
import 'package:catch_all_app/domain/models/user_model.dart';
import 'package:local_storage/local_storage.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final LocalStorage _localStorage;

  static const String _userBox = 'user_box';
  static const String _userKey = 'current_user';

  AuthRepositoryImpl({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    LocalStorage? localStorage,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _localStorage = localStorage ?? LocalStorage.instance;

  @override
  Future<UserModel> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      throw Exception('Google sign in aborted');
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the credential
    final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);

    final User? firebaseUser = userCredential.user;

    if (firebaseUser == null) {
      throw Exception('Failed to sign in to Firebase');
    }

    final userModel = UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email,
      displayName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL,
    );

    // Save user info to local storage
    await _saveUserToLocal(userModel);

    return userModel;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final String? userJson = await _localStorage.get<String>(_userBox, _userKey);
      if (userJson != null) {
        return UserModel.fromJson(jsonDecode(userJson));
      }
    } catch (e) {
      // Ignored: fallback to Firebase
    }

    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      return UserModel(
        id: firebaseUser.uid,
        email: firebaseUser.email,
        displayName: firebaseUser.displayName,
        photoUrl: firebaseUser.photoURL,
      );
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
    await _localStorage.delete(_userBox, _userKey);
  }

  Future<void> _saveUserToLocal(UserModel user) async {
    final userJson = jsonEncode(user.toJson());
    await _localStorage.put<String>(_userBox, _userKey, userJson);
  }
}
