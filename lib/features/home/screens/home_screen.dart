import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/models/user_model.dart';
import '../../auth/providers/auth_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final userData = authState.userData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CoachingEdge'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // Navigate to notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              context.push('/profile');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            _buildWelcomeSection(userData),
            
            const SizedBox(height: AppConstants.spacingXL),
            
            // Quick Actions
            _buildQuickActions(context),
            
            const SizedBox(height: AppConstants.spacingXL),
            
            // Recent Courses
            _buildRecentCourses(),
            
            const SizedBox(height: AppConstants.spacingXL),
            
            // Live Classes
            _buildLiveClasses(),
            
            const SizedBox(height: AppConstants.spacingXL),
            
            // Sign Out Button
            if (userData != null) _buildSignOutButton(ref),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildWelcomeSection(UserModel? userData) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingL),
      decoration: BoxDecoration(
        gradient: AppConstants.primaryGradient,
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        boxShadow: AppConstants.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back,',
            style: AppConstants.body2.copyWith(
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: AppConstants.spacingS),
          Text(
            userData?.name ?? 'User',
            style: AppConstants.heading2.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppConstants.spacingM),
          Row(
            children: [
              Icon(
                Icons.school,
                color: Colors.white.withOpacity(0.8),
                size: 20,
              ),
              const SizedBox(width: AppConstants.spacingS),
              Text(
                userData?.role.toUpperCase() ?? 'STUDENT',
                style: AppConstants.body2.copyWith(
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: AppConstants.heading3,
        ),
        const SizedBox(height: AppConstants.spacingM),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: AppConstants.spacingM,
          mainAxisSpacing: AppConstants.spacingM,
          childAspectRatio: 1.2,
          children: [
            _buildActionCard(
              icon: Icons.play_circle_outline,
              title: 'My Courses',
              subtitle: 'Continue learning',
              onTap: () => context.push('/courses'),
            ),
            _buildActionCard(
              icon: Icons.video_camera_front_outlined,
              title: 'Live Classes',
              subtitle: 'Join sessions',
              onTap: () => context.push('/live-classes'),
            ),
            _buildActionCard(
              icon: Icons.quiz_outlined,
              title: 'Quizzes',
              subtitle: 'Test knowledge',
              onTap: () => context.push('/quiz'),
            ),
            _buildActionCard(
              icon: Icons.chat_outlined,
              title: 'Community',
              subtitle: 'Discuss topics',
              onTap: () => context.push('/chat'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.spacingM),
        decoration: BoxDecoration(
          color: AppConstants.surfaceColor,
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          boxShadow: AppConstants.cardShadow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: AppConstants.primaryColor,
            ),
            const SizedBox(height: AppConstants.spacingS),
            Text(
              title,
              style: AppConstants.body1.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.spacingXS),
            Text(
              subtitle,
              style: AppConstants.caption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentCourses() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Courses',
              style: AppConstants.heading3,
            ),
            TextButton(
              onPressed: () {
                // Navigate to all courses
              },
              child: Text(
                'View All',
                style: AppConstants.body2.copyWith(
                  color: AppConstants.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingM),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                width: 280,
                margin: EdgeInsets.only(
                  right: index < 2 ? AppConstants.spacingM : 0,
                ),
                child: _buildCourseCard(index),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCourseCard(int index) {
    final courses = [
      {
        'title': 'Advanced Mathematics',
        'teacher': 'Dr. Sarah Johnson',
        'duration': '12 hours',
        'progress': 0.7,
      },
      {
        'title': 'Physics Fundamentals',
        'teacher': 'Prof. Michael Chen',
        'duration': '8 hours',
        'progress': 0.3,
      },
      {
        'title': 'Computer Science Basics',
        'teacher': 'Dr. Emily Davis',
        'duration': '15 hours',
        'progress': 0.0,
      },
    ];

    final course = courses[index];

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingM),
      decoration: BoxDecoration(
        color: AppConstants.surfaceColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        boxShadow: AppConstants.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: AppConstants.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusS),
            ),
            child: const Center(
              child: Icon(
                Icons.school,
                size: 40,
                color: AppConstants.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: AppConstants.spacingM),
          Text(
            course['title'] as String,
            style: AppConstants.body1.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppConstants.spacingXS),
          Text(
            course['teacher'] as String,
            style: AppConstants.caption,
          ),
          const SizedBox(height: AppConstants.spacingS),
          Row(
            children: [
              const Icon(
                Icons.access_time,
                size: 16,
                color: AppConstants.textSecondary,
              ),
              const SizedBox(width: AppConstants.spacingXS),
              Text(
                course['duration'] as String,
                style: AppConstants.caption,
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingS),
          LinearProgressIndicator(
            value: course['progress'] as double,
            backgroundColor: AppConstants.textTertiary.withOpacity(0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(AppConstants.primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveClasses() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Upcoming Live Classes',
              style: AppConstants.heading3,
            ),
            TextButton(
              onPressed: () {
                // Navigate to all live classes
              },
              child: Text(
                'View All',
                style: AppConstants.body2.copyWith(
                  color: AppConstants.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingM),
        Container(
          padding: const EdgeInsets.all(AppConstants.spacingM),
          decoration: BoxDecoration(
            color: AppConstants.accentColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
            border: Border.all(
              color: AppConstants.accentColor.withOpacity(0.3),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppConstants.spacingS),
                decoration: BoxDecoration(
                  color: AppConstants.accentColor,
                  borderRadius: BorderRadius.circular(AppConstants.radiusS),
                ),
                child: const Icon(
                  Icons.video_camera_front,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppConstants.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mathematics Live Session',
                      style: AppConstants.body1.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingXS),
                    Text(
                      'Today at 3:00 PM',
                      style: AppConstants.caption,
                    ),
                  ],
                ),
              ),
              CustomButton(
                text: 'Join',
                type: ButtonType.secondary,
                isFullWidth: false,
                width: 80,
                height: 36,
                onPressed: () {
                  // Join live class
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSignOutButton(WidgetRef ref) {
    return CustomButton(
      text: 'Sign Out',
      type: ButtonType.outline,
      onPressed: () async {
        await ref.read(authProvider.notifier).signOut();
      },
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppConstants.primaryColor,
      unselectedItemColor: AppConstants.textSecondary,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.play_circle_outline),
          activeIcon: Icon(Icons.play_circle),
          label: 'Courses',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.video_camera_front_outlined),
          activeIcon: Icon(Icons.video_camera_front),
          label: 'Live',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_outlined),
          activeIcon: Icon(Icons.chat),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            // Already on home
            break;
          case 1:
            context.push('/courses');
            break;
          case 2:
            context.push('/live-classes');
            break;
          case 3:
            context.push('/chat');
            break;
          case 4:
            context.push('/profile');
            break;
        }
      },
    );
  }
} 