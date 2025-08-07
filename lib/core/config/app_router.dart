import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/home/screens/home_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isAuthenticated = authState.user != null;
      final isAuthRoute = state.matchedLocation == '/login' || 
                         state.matchedLocation == '/signup' ||
                         state.matchedLocation == '/forgot-password';
      
      // If user is not authenticated and not on auth route, redirect to login
      if (!isAuthenticated && !isAuthRoute) {
        return '/login';
      }
      
      // If user is authenticated and on auth route, redirect to home
      if (isAuthenticated && isAuthRoute) {
        return '/';
      }
      
      return null;
    },
    routes: [
      // Auth Routes
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      
      // Main App Routes
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
        routes: [
          // Course Routes
          GoRoute(
            path: 'courses',
            name: 'courses',
            builder: (context, state) => const CoursesScreen(),
            routes: [
              GoRoute(
                path: ':courseId',
                name: 'course-details',
                builder: (context, state) => CourseDetailsScreen(
                  courseId: state.pathParameters['courseId']!,
                ),
              ),
              GoRoute(
                path: ':courseId/lesson/:lessonId',
                name: 'lesson',
                builder: (context, state) => LessonScreen(
                  courseId: state.pathParameters['courseId']!,
                  lessonId: state.pathParameters['lessonId']!,
                ),
              ),
            ],
          ),
          
          // Live Classes Routes
          GoRoute(
            path: 'live-classes',
            name: 'live-classes',
            builder: (context, state) => const LiveClassesScreen(),
            routes: [
              GoRoute(
                path: ':classId',
                name: 'live-class-details',
                builder: (context, state) => LiveClassDetailsScreen(
                  classId: state.pathParameters['classId']!,
                ),
              ),
              GoRoute(
                path: ':classId/join',
                name: 'join-live-class',
                builder: (context, state) => JoinLiveClassScreen(
                  classId: state.pathParameters['classId']!,
                ),
              ),
            ],
          ),
          
          // Quiz Routes
          GoRoute(
            path: 'quiz',
            name: 'quiz',
            builder: (context, state) => const QuizScreen(),
            routes: [
              GoRoute(
                path: ':quizId',
                name: 'take-quiz',
                builder: (context, state) => TakeQuizScreen(
                  quizId: state.pathParameters['quizId']!,
                ),
              ),
              GoRoute(
                path: ':quizId/results',
                name: 'quiz-results',
                builder: (context, state) => QuizResultsScreen(
                  quizId: state.pathParameters['quizId']!,
                ),
              ),
            ],
          ),
          
          // Chat Routes
          GoRoute(
            path: 'chat',
            name: 'chat',
            builder: (context, state) => const ChatScreen(),
            routes: [
              GoRoute(
                path: ':chatId',
                name: 'chat-room',
                builder: (context, state) => ChatRoomScreen(
                  chatId: state.pathParameters['chatId']!,
                ),
              ),
            ],
          ),
          
          // Profile Routes
          GoRoute(
            path: 'profile',
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
            routes: [
              GoRoute(
                path: 'edit',
                name: 'edit-profile',
                builder: (context, state) => const EditProfileScreen(),
              ),
              GoRoute(
                path: 'settings',
                name: 'settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
          
          // Payment Routes
          GoRoute(
            path: 'payments',
            name: 'payments',
            builder: (context, state) => const PaymentsScreen(),
            routes: [
              GoRoute(
                path: 'history',
                name: 'payment-history',
                builder: (context, state) => const PaymentHistoryScreen(),
              ),
            ],
          ),
          
          // Admin Routes (only for admin users)
          GoRoute(
            path: 'admin',
            name: 'admin',
            builder: (context, state) => const AdminDashboardScreen(),
            routes: [
              GoRoute(
                path: 'courses',
                name: 'admin-courses',
                builder: (context, state) => const AdminCoursesScreen(),
              ),
              GoRoute(
                path: 'users',
                name: 'admin-users',
                builder: (context, state) => const AdminUsersScreen(),
              ),
              GoRoute(
                path: 'analytics',
                name: 'admin-analytics',
                builder: (context, state) => const AdminAnalyticsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const ErrorScreen(),
  );
});

// Placeholder screens - these will be implemented later
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: const Center(child: Text('Forgot Password Screen')),
    );
  }
}

// HomeScreen is now imported from features/home/screens/home_screen.dart

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Courses')),
      body: const Center(child: Text('Courses Screen')),
    );
  }
}

class CourseDetailsScreen extends StatelessWidget {
  final String courseId;
  
  const CourseDetailsScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Course $courseId')),
      body: Center(child: Text('Course Details Screen - $courseId')),
    );
  }
}

class LessonScreen extends StatelessWidget {
  final String courseId;
  final String lessonId;
  
  const LessonScreen({super.key, required this.courseId, required this.lessonId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lesson $lessonId')),
      body: Center(child: Text('Lesson Screen - Course: $courseId, Lesson: $lessonId')),
    );
  }
}

class LiveClassesScreen extends StatelessWidget {
  const LiveClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Classes')),
      body: const Center(child: Text('Live Classes Screen')),
    );
  }
}

class LiveClassDetailsScreen extends StatelessWidget {
  final String classId;
  
  const LiveClassDetailsScreen({super.key, required this.classId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Live Class $classId')),
      body: Center(child: Text('Live Class Details Screen - $classId')),
    );
  }
}

class JoinLiveClassScreen extends StatelessWidget {
  final String classId;
  
  const JoinLiveClassScreen({super.key, required this.classId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Join Class $classId')),
      body: Center(child: Text('Join Live Class Screen - $classId')),
    );
  }
}

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: const Center(child: Text('Quiz Screen')),
    );
  }
}

class TakeQuizScreen extends StatelessWidget {
  final String quizId;
  
  const TakeQuizScreen({super.key, required this.quizId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz $quizId')),
      body: Center(child: Text('Take Quiz Screen - $quizId')),
    );
  }
}

class QuizResultsScreen extends StatelessWidget {
  final String quizId;
  
  const QuizResultsScreen({super.key, required this.quizId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz Results $quizId')),
      body: Center(child: Text('Quiz Results Screen - $quizId')),
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: const Center(child: Text('Chat Screen')),
    );
  }
}

class ChatRoomScreen extends StatelessWidget {
  final String chatId;
  
  const ChatRoomScreen({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat $chatId')),
      body: Center(child: Text('Chat Room Screen - $chatId')),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Center(child: Text('Profile Screen')),
    );
  }
}

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: const Center(child: Text('Edit Profile Screen')),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('Settings Screen')),
    );
  }
}

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payments')),
      body: const Center(child: Text('Payments Screen')),
    );
  }
}

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment History')),
      body: const Center(child: Text('Payment History Screen')),
    );
  }
}

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: const Center(child: Text('Admin Dashboard Screen')),
    );
  }
}

class AdminCoursesScreen extends StatelessWidget {
  const AdminCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Courses')),
      body: const Center(child: Text('Admin Courses Screen')),
    );
  }
}

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Users')),
      body: const Center(child: Text('Admin Users Screen')),
    );
  }
}

class AdminAnalyticsScreen extends StatelessWidget {
  const AdminAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Analytics')),
      body: const Center(child: Text('Admin Analytics Screen')),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text('Page not found', style: TextStyle(fontSize: 24)),
            SizedBox(height: 8),
            Text('The page you are looking for does not exist.'),
          ],
        ),
      ),
    );
  }
} 