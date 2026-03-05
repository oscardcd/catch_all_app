import 'dart:convert';
import 'package:catch_all_app/domain/services/auth_service.dart';
import 'package:catch_all_app/domain/repositories/auth_repository.dart';
import 'package:catch_all_app/domain/models/user_model.dart';
import 'package:client_api/client_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_storage/local_storage.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final AuthService _authService;
  final LocalStorage _localStorage;

  static const String _userBox = 'user_box';
  static const String _userKey = 'current_user';

  AuthRepositoryImpl({
    required AuthService authService,
    LocalStorage? localStorage,
  })  : _authService = authService,
        _localStorage = localStorage ?? LocalStorage.instance;

  @override
  Future<UserModel> signInWithGoogle() async {
    final result = await _authService.signInWithGoogle();

    return result.when(
      success: (userModel) async {
        // Save user info to local storage on success
        await _saveUserToLocal(userModel);
        return userModel;
      },
      failure: (error) {
        if (error is FirebaseAuthException) {
          throw _handleAuthError(error);
        }
        throw Exception('An unexpected authentication error occurred: $error');
      },
    );
  }

  @override
  Future<UserModel> signInWithFirebase() async {
    final result = await _authService.signInWithFirebase();

    return result.when(
      success: (userModel) async {
        // Save user info to local storage on success
        await _saveUserToLocal(userModel);
        return userModel;
      },
      failure: (error) {
        if (error is FirebaseAuthException) {
          throw _handleAuthError(error);
        }
        throw Exception('An unexpected authentication error occurred: $error');
      },
    );
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(String email, String password) async {
    final result = await _authService.signInWithEmailAndPassword(email, password);

    return result.when(
      success: (userModel) async {
        await _saveUserToLocal(userModel);
        return userModel;
      },
      failure: (error) {
        throw Exception(error.toString());
      },
    );
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final String? userJson = await _localStorage.get<String>(_userBox, _userKey);
      if (userJson != null) {
        return UserModel.fromJson(jsonDecode(userJson));
      }
    } catch (e) {
      // Ignored: fallback to AuthService
    }

    final firebaseUser = _authService.currentUser;
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
    await _authService.signOut();
    await _localStorage.delete(_userBox, _userKey);
  }

  Future<void> _saveUserToLocal(UserModel user) async {
    final userJson = jsonEncode(user.toJson());
    await _localStorage.put<String>(_userBox, _userKey, userJson);
  }

  Exception _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'ERROR_ABORTED_BY_USER':
        return Exception('Inicio de sesión cancelado por el usuario');
      case 'network-request-failed':
        return Exception('Error de red. Verifica tu conexión');
      case 'invalid-credential':
        return Exception('Credenciales inválidas');
      default:
        return Exception('Error de autenticación: ${e.message}');
    }
  }
}
