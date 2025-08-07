import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../providers/auth_provider.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _gradeController = TextEditingController();
  final _schoolController = TextEditingController();
  final _qualificationController = TextEditingController();
  final _specializationController = TextEditingController();
  
  String _selectedRole = 'student';
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _gradeController.dispose();
    _schoolController.dispose();
    _qualificationController.dispose();
    _specializationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppConstants.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Create Account',
          style: AppConstants.heading3,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.spacingL),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Role Selection
                _buildRoleSelection(),
                
                const SizedBox(height: AppConstants.spacingL),
                
                // Basic Information
                _buildBasicInfo(),
                
                const SizedBox(height: AppConstants.spacingL),
                
                // Role-specific Information
                _buildRoleSpecificInfo(),
                
                const SizedBox(height: AppConstants.spacingL),
                
                // Sign Up Button
                _buildSignUpButton(authState),
                
                const SizedBox(height: AppConstants.spacingL),
                
                // Login Link
                _buildLoginLink(),
                
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

  Widget _buildRoleSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'I am a',
          style: AppConstants.body1.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        
        const SizedBox(height: AppConstants.spacingM),
        
        Row(
          children: [
            Expanded(
              child: _buildRoleCard(
                title: 'Student',
                subtitle: 'Learn from experts',
                icon: Icons.school,
                isSelected: _selectedRole == 'student',
                onTap: () => setState(() => _selectedRole = 'student'),
              ),
            ),
            
            const SizedBox(width: AppConstants.spacingM),
            
            Expanded(
              child: _buildRoleCard(
                title: 'Teacher',
                subtitle: 'Share knowledge',
                icon: Icons.person,
                isSelected: _selectedRole == 'teacher',
                onTap: () => setState(() => _selectedRole = 'teacher'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRoleCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.spacingM),
        decoration: BoxDecoration(
          color: isSelected ? AppConstants.primaryColor : AppConstants.surfaceColor,
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          border: Border.all(
            color: isSelected ? AppConstants.primaryColor : AppConstants.textTertiary.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: isSelected ? AppConstants.cardShadow : null,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? Colors.white : AppConstants.textSecondary,
            ),
            
            const SizedBox(height: AppConstants.spacingS),
            
            Text(
              title,
              style: AppConstants.body1.copyWith(
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : AppConstants.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: AppConstants.spacingXS),
            
            Text(
              subtitle,
              style: AppConstants.caption.copyWith(
                color: isSelected ? Colors.white.withOpacity(0.8) : AppConstants.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Basic Information',
          style: AppConstants.heading3,
        ),
        
        const SizedBox(height: AppConstants.spacingM),
        
        CustomTextField(
          controller: _nameController,
          label: 'Full Name',
          hint: 'Enter your full name',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            if (value.length < 2) {
              return 'Name must be at least 2 characters';
            }
            return null;
          },
          prefixIcon: const Icon(Icons.person_outlined),
        ),
        
        const SizedBox(height: AppConstants.spacingM),
        
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
        
        const SizedBox(height: AppConstants.spacingM),
        
        CustomTextField(
          controller: _passwordController,
          label: 'Password',
          hint: 'Create a strong password',
          obscureText: !_isPasswordVisible,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
          prefixIcon: const Icon(Icons.lock_outlined),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: AppConstants.textSecondary,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
        ),
        
        const SizedBox(height: AppConstants.spacingM),
        
        CustomTextField(
          controller: _confirmPasswordController,
          label: 'Confirm Password',
          hint: 'Confirm your password',
          obscureText: !_isConfirmPasswordVisible,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please confirm your password';
            }
            if (value != _passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
          prefixIcon: const Icon(Icons.lock_outlined),
          suffixIcon: IconButton(
            icon: Icon(
              _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: AppConstants.textSecondary,
            ),
            onPressed: () {
              setState(() {
                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRoleSpecificInfo() {
    if (_selectedRole == 'student') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Student Information',
            style: AppConstants.heading3,
          ),
          
          const SizedBox(height: AppConstants.spacingM),
          
          CustomTextField(
            controller: _gradeController,
            label: 'Grade/Class',
            hint: 'e.g., 10th, 12th, B.Tech 2nd Year',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your grade/class';
              }
              return null;
            },
            prefixIcon: const Icon(Icons.grade_outlined),
          ),
          
          const SizedBox(height: AppConstants.spacingM),
          
          CustomTextField(
            controller: _schoolController,
            label: 'School/College',
            hint: 'Enter your school or college name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your school/college';
              }
              return null;
            },
            prefixIcon: const Icon(Icons.school_outlined),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Teacher Information',
            style: AppConstants.heading3,
          ),
          
          const SizedBox(height: AppConstants.spacingM),
          
          CustomTextField(
            controller: _qualificationController,
            label: 'Qualification',
            hint: 'e.g., M.Tech, Ph.D., B.Ed',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your qualification';
              }
              return null;
            },
            prefixIcon: const Icon(Icons.school_outlined),
          ),
          
          const SizedBox(height: AppConstants.spacingM),
          
          CustomTextField(
            controller: _specializationController,
            label: 'Specialization',
            hint: 'e.g., Mathematics, Physics, Computer Science',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your specialization';
              }
              return null;
            },
            prefixIcon: const Icon(Icons.science_outlined),
          ),
        ],
      );
    }
  }

  Widget _buildSignUpButton(AuthState authState) {
    return CustomButton(
      text: 'Create Account',
      onPressed: authState.isLoading ? null : _handleSignUp,
      isLoading: authState.isLoading,
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: AppConstants.body2,
        ),
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: Text(
            'Sign In',
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

  void _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(authProvider.notifier).createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        name: _nameController.text.trim(),
        role: _selectedRole,
        phoneNumber: _phoneController.text.trim(),
        grade: _selectedRole == 'student' ? _gradeController.text.trim() : null,
        school: _selectedRole == 'student' ? _schoolController.text.trim() : null,
        qualification: _selectedRole == 'teacher' ? _qualificationController.text.trim() : null,
        specialization: _selectedRole == 'teacher' ? _specializationController.text.trim() : null,
      );
    }
  }
} 