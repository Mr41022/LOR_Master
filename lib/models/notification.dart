// Abstract base class
abstract class BaseNotification {
  String title;
  String message;
  String timestamp;
  String targetRole;

  BaseNotification({
    required this.title,
    required this.message,
    required this.timestamp,
    required this.targetRole,
  });
}

// Concrete implementation
class StudentNotification extends BaseNotification {
  StudentNotification({
    required String title,
    required String message,
    required String timestamp,
    required String targetRole,
  }) : super(
          title: title,
          message: message,
          timestamp: timestamp,
          targetRole: targetRole,
        );

  factory StudentNotification.fromJson(Map<String, dynamic> json) {
    return StudentNotification(
      title: json['title'],
      message: json['message'],
      timestamp: json['timestamp'],
      targetRole: json['targetRole'],
    );
  }
}
