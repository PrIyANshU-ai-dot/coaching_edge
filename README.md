# CoachingEdge - Flutter Learning Platform

A comprehensive Flutter mobile application for a local coaching institute, similar in functionality and UX to Unacademy. The app supports Android (initial deployment) and iOS (planned for later) with Firebase as the backend.

## 🚀 Features

### 🔐 Authentication
- Firebase Authentication (Email, Phone OTP login)
- Role-based access: **Student**, **Teacher**, **Admin**
- Email verification and password reset

### 📚 Course & Video Content
- Courses categorized by Subject & Teacher
- List of video lectures (Firebase Storage or YouTube embed)
- Course description, duration, and syllabus
- Progress tracking per course

### 🧑‍🏫 Live Classes
- Integration with **Agora** for live sessions
- Scheduled class interface with reminders
- Join button with countdown timer

### 📝 Quiz & Assessment
- MCQ quizzes after each lesson
- Score calculation and ranking
- Store responses in Firebase Firestore

### 💬 Chat & Community
- Real-time discussion thread for each course (Firestore-based)
- One-on-one student-teacher chat
- Notifications for new messages using FCM

### 💳 Payments
- Razorpay integration for:
  - One-time course purchases
  - Subscription-based plans
- Payment history and invoice storage

### 🔔 Notifications
- Firebase Cloud Messaging (FCM) for:
  - Live class reminders
  - New course availability
  - Quiz results

### ⚙️ Admin Panel (Web)
- Use Flutter Web or React
- Features:
  - Add/update/delete courses
  - Upload videos
  - Manage users and roles
  - View analytics (users, views, payments)

## 🧰 Tech Stack

- **Flutter** (cross-platform mobile)
- **Firebase** (Auth, Firestore, Storage, FCM)
- **Agora** (live classes)
- **Razorpay** (payments)
- **State Management:** Riverpod
- **UI:** Material 3, responsive, mobile-first
- **Routing:** go_router

## 📁 Project Structure

```
lib/
├── core/
│   ├── config/
│   │   ├── app_config.dart
│   │   └── app_router.dart
│   ├── constants/
│   │   └── app_constants.dart
│   ├── errors/
│   ├── network/
│   └── utils/
├── features/
│   ├── auth/
│   │   ├── providers/
│   │   ├── screens/
│   │   └── services/
│   ├── courses/
│   ├── live_classes/
│   ├── quiz/
│   ├── chat/
│   ├── payments/
│   ├── notifications/
│   └── admin/
└── shared/
    ├── models/
    ├── services/
    ├── widgets/
    └── providers/
```

## 🛠️ Setup Instructions

### Prerequisites
- Flutter SDK (>=3.2.3)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- Firebase account
- Agora account (for live classes)
- Razorpay account (for payments)

### 1. Clone the Repository
```bash
git clone <repository-url>
cd coaching_edge
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Firebase Setup

#### Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project
3. Enable Authentication, Firestore, Storage, and Cloud Messaging

#### Add Android App
1. In Firebase Console, add Android app
2. Package name: `com.coachingedge.app`
3. Download `google-services.json` and place it in `android/app/`

#### Add iOS App (for future)
1. In Firebase Console, add iOS app
2. Bundle ID: `com.coachingedge.app`
3. Download `GoogleService-Info.plist` and place it in `ios/Runner/`

### 4. Configure Environment Variables

Update `lib/core/config/app_config.dart` with your API keys:

```dart
// Agora Configuration
static const String agoraAppId = 'YOUR_AGORA_APP_ID';
static const String agoraToken = 'YOUR_AGORA_TOKEN';

// Razorpay Configuration
static const String razorpayKeyId = 'YOUR_RAZORPAY_KEY_ID';
static const String razorpayKeySecret = 'YOUR_RAZORPAY_KEY_SECRET';
```

### 5. Generate Code
```bash
flutter packages pub run build_runner build
```

### 6. Run the App
```bash
flutter run
```

## 🔧 Development Guidelines

### Code Style
- Follow Dart/Flutter conventions
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused

### State Management
- Use Riverpod for state management
- Keep providers in feature-specific folders
- Use `@riverpod` annotation for code generation

### UI/UX
- Follow Material 3 design guidelines
- Use consistent spacing and typography
- Implement responsive design
- Add loading states and error handling

### Testing
- Write unit tests for business logic
- Write widget tests for UI components
- Test authentication flows
- Test payment integration

## 📱 App Screenshots

[Add screenshots here]

## 🚀 Deployment

### Android
1. Build APK:
```bash
flutter build apk --release
```

2. Build App Bundle:
```bash
flutter build appbundle --release
```

### iOS (Future)
1. Build iOS:
```bash
flutter build ios --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support, email support@coachingedge.com or create an issue in the repository.

## 🔄 Changelog

### v1.0.0
- Initial release
- Authentication system
- Basic course structure
- Firebase integration

## 🎯 Roadmap

- [ ] Live class integration with Agora
- [ ] Payment integration with Razorpay
- [ ] Quiz and assessment system
- [ ] Chat and community features
- [ ] Admin panel
- [ ] iOS support
- [ ] Web admin panel
- [ ] Advanced analytics
- [ ] Offline support
- [ ] Push notifications
