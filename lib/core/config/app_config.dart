import 'package:flutter/foundation.dart';

class AppConfig {
  static const String appName = 'CoachingEdge';
  static const String appVersion = '1.0.0';
  
  // Firebase Configuration
  static const String firebaseProjectId = 'coaching-edge-app';
  
  // Agora Configuration (for live classes)
  static const String agoraAppId = 'YOUR_AGORA_APP_ID';
  static const String agoraToken = 'YOUR_AGORA_TOKEN';
  
  // Razorpay Configuration
  static const String razorpayKeyId = 'YOUR_RAZORPAY_KEY_ID';
  static const String razorpayKeySecret = 'YOUR_RAZORPAY_KEY_SECRET';
  
  // API Configuration
  static const String baseUrl = 'https://api.coachingedge.com';
  static const int apiTimeout = 30000; // 30 seconds
  
  // App Configuration
  static const bool isDebug = kDebugMode;
  static const int maxRetryAttempts = 3;
  static const Duration cacheExpiry = Duration(hours: 24);
  
  // Video Configuration
  static const int maxVideoDuration = 7200; // 2 hours in seconds
  static const int maxFileSize = 100 * 1024 * 1024; // 100MB
  
  // Notification Configuration
  static const String fcmTopicGeneral = 'general';
  static const String fcmTopicLiveClasses = 'live_classes';
  static const String fcmTopicNewCourses = 'new_courses';
} 