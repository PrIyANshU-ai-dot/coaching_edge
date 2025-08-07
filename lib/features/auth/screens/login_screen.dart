import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  
  bool _isEmailLogin = true;
  bool _showOtpField = false;
  String? _verificationId;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.spacingL),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppConstants.spacingXXL),
                
                // Logo and Title
                _buildHeader(),
                
                const SizedBox(height: AppConstants.spacingXXL),
                
                // Login Type Toggle
                _buildLoginTypeToggle(),
                
                const SizedBox(height: AppConstants.spacingL),
                
                // Login Form
                _buildLoginForm(),
                
                const SizedBox(height: AppConstants.spacingL),
                
                // Login Button
                _buildLoginButton(authState),
                
                const SizedBox(height: AppConstants.spacingL),
                
                // Forgot Password
                if (_isEmailLogin) _buildForgotPassword(),
                
                const SizedBox(height: AppConstants.spacingL),
                
                // Sign Up Link
                _buildSignUpLink(),
                
                const SizedBox(height: AppConstants.spacingL),
                
                // Error Message
                if (authState.error != null) _buildErrorMessage(authState.error!),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // App Logo
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: AppConstants.primaryGradient,
            borderRadius: BorderRadius.circular(AppConstants.radiusL),
            boxShadow: AppConstants.cardShadow,
          ),
          child: const Icon(
            Icons.school,
            size: 40,
            color: Colors.white,
          ),
        ),
        
        const SizedBox(height: AppConstants.spacingL),
        
        // App Name
        Text(
          'CoachingEdge',
          style: AppConstants.heading1,
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: AppConstants.spacingS),
        
        // Subtitle
        Text(
          'Your Gateway to Quality Education',
          style: AppConstants.body2,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLoginTypeToggle() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingS),
      decoration: BoxDecoration(
        color: AppConstants.surfaceColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        boxShadow: AppConstants.cardShadow,
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isEmailLogin = true;
                  _showOtpField = false;
                });
                ref.read(authProvider.notifier).clearError();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingM),
                decoration: BoxDecoration(
                  color: _isEmailLogin ? AppConstants.primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppConstants.radiusS),
                ),
                child: Text(
                  'Email',
                  style: AppConstants.body1.copyWith(
                    color: _isEmailLogin ? Colors.white : AppConstants.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isEmailLogin = false;
                  _showOtpField = false;
                });
                ref.read(authProvider.notifier).clearError();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingM),
                decoration: BoxDecoration(
                  color: !_isEmailLogin ? AppConstants.primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppConstants.radiusS),
                ),
                child: Text(
                  'Phone',
                  style: AppConstants.body1.copyWith(
                    color: !_isEmailLogin ? Colors.white : AppConstants.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    if (_isEmailLogin) {
      return Column(
        children: [
          CustomTextField(
            controller: _emailController,
            label: 'Email',
            hint: 'Enter your email address',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
            prefixIcon: const Icon(Icons.email_outlined),
          ),
          
          const SizedBox(height: AppConstants.spacingM),
          
          CustomTextField(
            controller: _passwordController,
            label: 'Password',
            hint: 'Enter your password',
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
            prefixIcon: const Icon(Icons.lock_outlined),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          CustomTextField(
            controller: _phoneController,
            label: 'Phone Number',
            hint: 'Enter your phone number',
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              if (value.length < 10) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
            prefixIcon: const Icon(Icons.phone_outlined),
          ),
          
          if (_showOtpField) ...[
            const SizedBox(height: AppConstants.spacingM),
            
            CustomTextField(
              controller: _otpController,
              label: 'OTP',
              hint: 'Enter 6-digit OTP',
              keyboardType: TextInputType.number,
              maxLength: 6,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter OTP';
                }
                if (value.length != 6) {
                  return 'Please enter 6-digit OTP';
                }
                return null;
              },
              prefixIcon: const Icon(Icons.security_outlined),
            ),
          ],
        ],
      );
    }
  }

  Widget _buildLoginButton(AuthState authState) {
    if (_isEmailLogin) {
      return CustomButton(
        text: 'Sign In',
        onPressed: authState.isLoading ? null : _handleEmailLogin,
        isLoading: authState.isLoading,
      );
    } else {
      if (_showOtpField) {
        return CustomButton(
          text: 'Verify OTP',
          onPressed: authState.isLoading ? null : _handleOtpVerification,
          isLoading: authState.isLoading,
        );
      } else {
        return CustomButton(
          text: 'Send OTP',
          onPressed: authState.isLoading ? null : _handlePhoneLogin,
          isLoading: authState.isLoading,
        );
      }
    }
  }

  Widget _buildForgotPassword() {
    return TextButton(
      onPressed: () {
        // Navigate to forgot password screen
        context.push('/forgot-password');
      },
      child: Text(
        'Forgot Password?',
        style: AppConstants.body2.copyWith(
          color: AppConstants.primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: AppConstants.body2,
        ),
        TextButton(
          onPressed: () {
            context.push('/signup');
          },
          child: Text(
            'Sign Up',
            style: AppConstants.body2.copyWith(
              color: AppConstants.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorMessage(String error) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingM),
      decoration: BoxDecoration(
        color: AppConstants.errorColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        border: Border.all(
          color: AppConstants.errorColor.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline,
            color: AppConstants.errorColor,
            size: 20,
          ),
          const SizedBox(width: AppConstants.spacingS),
          Expanded(
            child: Text(
              error,
              style: AppConstants.body2.copyWith(
                color: AppConstants.errorColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleEmailLogin() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(authProvider.notifier).signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    }
  }

  void _handlePhoneLogin() async {
    if (_formKey.currentState!.validate()) {
      final phoneNumber = _phoneController.text.trim();
      final formattedPhone = phoneNumber.startsWith('+91') 
          ? phoneNumber 
          : '+91$phoneNumber';
      
      await ref.read(authProvider.notifier).verifyPhoneNumber(
        phoneNumber: formattedPhone,
        onCodeSent: (verificationId) {
          setState(() {
            _verificationId = verificationId;
            _showOtpField = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('OTP sent to your phone number'),
              backgroundColor: AppConstants.successColor,
            ),
          );
        },
        onVerificationCompleted: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: AppConstants.successColor,
            ),
          );
        },
        onVerificationFailed: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error),
              backgroundColor: AppConstants.errorColor,
            ),
          );
        },
      );
    }
  }

  void _handleOtpVerification() async {
    if (_formKey.currentState!.validate() && _verificationId != null) {
      await ref.read(authProvider.notifier).verifyOTP(
        verificationId: _verificationId!,
        smsCode: _otpController.text.trim(),
      );
    }
  }
} 