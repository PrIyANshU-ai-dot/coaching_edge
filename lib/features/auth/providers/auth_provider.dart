import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../../../shared/models/user_model.dart';

// Auth service provider
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// Current user provider
final currentUserProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
});

// User data provider
final userDataProvider = FutureProvider.family<UserModel?, String>((ref, uid) async {
  final authService = ref.watch(authServiceProvider);
  return await authService.getUserData(uid);
});

// Auth state provider
class AuthState {
  final bool isLoading;
  final String? error;
  final User? user;
  final UserModel? userData;

  AuthState({
    this.isLoading = false,
    this.error,
    this.user,
    this.userData,
  });

  AuthState copyWith({
    bool? isLoading,
    String? error,
    User? user,
    UserModel? userData,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      user: user ?? this.user,
      userData: userData ?? this.userData,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(AuthState());

  // Sign in with email and password
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Sign up with email and password
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String role,
    String? phoneNumber,
    String? grade,
    String? school,
    String? qualification,
    String? specialization,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      await _authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
        role: role,
        phoneNumber: phoneNumber,
        grade: grade,
        school: school,
        qualification: qualification,
        specialization: specialization,
      );
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Sign in with phone number
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(String) onCodeSent,
    required Function(String) onVerificationCompleted,
    required Function(String) onVerificationFailed,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      await _authService.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        onCodeSent: onCodeSent,
        onVerificationCompleted: onVerificationCompleted,
        onVerificationFailed: onVerificationFailed,
      );
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Verify OTP
  Future<void> verifyOTP({
    required String verificationId,
    required String smsCode,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      await _authService.verifyOTP(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Sign out
  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      await _authService.signOut();
      state = state.copyWith(isLoading: false, user: null, userData: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      await _authService.resetPassword(email);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Update user data
  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      await _authService.updateUserData(uid, data);
      
      // Update local user data if available
      if (state.userData != null) {
        final updatedUserData = state.userData!.copyWith(
          name: data['name'] ?? state.userData!.name,
          phoneNumber: data['phoneNumber'] ?? state.userData!.phoneNumber,
          grade: data['grade'] ?? state.userData!.grade,
          school: data['school'] ?? state.userData!.school,
          qualification: data['qualification'] ?? state.userData!.qualification,
          specialization: data['specialization'] ?? state.userData!.specialization,
        );
        state = state.copyWith(isLoading: false, userData: updatedUserData);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Load user data
  Future<void> loadUserData(String uid) async {
    try {
      final userData = await _authService.getUserData(uid);
      state = state.copyWith(userData: userData);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  // Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthNotifier(authService);
});

// Convenience providers
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider);
  return authState.user != null;
});

final currentUserDataProvider = Provider<UserModel?>((ref) {
  final authState = ref.watch(authProvider);
  return authState.userData;
});

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider);
  return authState.isLoading;
});

final authErrorProvider = Provider<String?>((ref) {
  final authState = ref.watch(authProvider);
  return authState.error;
}); 