import 'package:json_annotation/json_annotation.dart';

part 'course_model.g.dart';

@JsonSerializable()
class CourseModel {
  final String id;
  final String title;
  final String description;
  final String subject;
  final String teacherId;
  final String teacherName;
  final String? teacherImage;
  final List<String> tags;
  final String difficulty; // beginner, intermediate, advanced
  final int duration; // total duration in minutes
  final int totalLessons;
  final int totalStudents;
  final double rating;
  final int totalRatings;
  final double price;
  final bool isFree;
  final bool isPublished;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? thumbnail;
  final String? previewVideo;
  final List<LessonModel> lessons;
  final List<String> prerequisites;
  final List<String> learningOutcomes;
  final Map<String, dynamic> metadata; // Additional data like syllabus, etc.
  
  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.subject,
    required this.teacherId,
    required this.teacherName,
    this.teacherImage,
    this.tags = const [],
    required this.difficulty,
    required this.duration,
    required this.totalLessons,
    this.totalStudents = 0,
    this.rating = 0.0,
    this.totalRatings = 0,
    required this.price,
    required this.isFree,
    required this.isPublished,
    required this.createdAt,
    this.updatedAt,
    this.thumbnail,
    this.previewVideo,
    this.lessons = const [],
    this.prerequisites = const [],
    this.learningOutcomes = const [],
    this.metadata = const {},
  });
  
  factory CourseModel.fromJson(Map<String, dynamic> json) => _$CourseModelFromJson(json);
  Map<String, dynamic> toJson() => _$CourseModelToJson(this);
  
  CourseModel copyWith({
    String? id,
    String? title,
    String? description,
    String? subject,
    String? teacherId,
    String? teacherName,
    String? teacherImage,
    List<String>? tags,
    String? difficulty,
    int? duration,
    int? totalLessons,
    int? totalStudents,
    double? rating,
    int? totalRatings,
    double? price,
    bool? isFree,
    bool? isPublished,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? thumbnail,
    String? previewVideo,
    List<LessonModel>? lessons,
    List<String>? prerequisites,
    List<String>? learningOutcomes,
    Map<String, dynamic>? metadata,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      subject: subject ?? this.subject,
      teacherId: teacherId ?? this.teacherId,
      teacherName: teacherName ?? this.teacherName,
      teacherImage: teacherImage ?? this.teacherImage,
      tags: tags ?? this.tags,
      difficulty: difficulty ?? this.difficulty,
      duration: duration ?? this.duration,
      totalLessons: totalLessons ?? this.totalLessons,
      totalStudents: totalStudents ?? this.totalStudents,
      rating: rating ?? this.rating,
      totalRatings: totalRatings ?? this.totalRatings,
      price: price ?? this.price,
      isFree: isFree ?? this.isFree,
      isPublished: isPublished ?? this.isPublished,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      thumbnail: thumbnail ?? this.thumbnail,
      previewVideo: previewVideo ?? this.previewVideo,
      lessons: lessons ?? this.lessons,
      prerequisites: prerequisites ?? this.prerequisites,
      learningOutcomes: learningOutcomes ?? this.learningOutcomes,
      metadata: metadata ?? this.metadata,
    );
  }
  
  String get formattedDuration {
    final hours = duration ~/ 60;
    final minutes = duration % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }
  
  String get formattedPrice {
    if (isFree) return 'Free';
    return '₹${price.toStringAsFixed(0)}';
  }
  
  bool get hasPreview => previewVideo != null && previewVideo!.isNotEmpty;
}

@JsonSerializable()
class LessonModel {
  final String id;
  final String title;
  final String description;
  final int duration; // in minutes
  final String videoUrl;
  final String? thumbnail;
  final bool isFree;
  final int order;
  final List<String> resources; // PDFs, documents, etc.
  final Map<String, dynamic> metadata;
  
  LessonModel({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.videoUrl,
    this.thumbnail,
    required this.isFree,
    required this.order,
    this.resources = const [],
    this.metadata = const {},
  });
  
  factory LessonModel.fromJson(Map<String, dynamic> json) => _$LessonModelFromJson(json);
  Map<String, dynamic> toJson() => _$LessonModelToJson(this);
  
  String get formattedDuration {
    final hours = duration ~/ 60;
    final minutes = duration % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }
} 