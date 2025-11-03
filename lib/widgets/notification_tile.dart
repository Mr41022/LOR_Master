import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  final Notification notification;

  const NotificationTile({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Icon(Icons.notifications, color: Colors.white),
      ),
      title: Text('Accepted'),
      subtitle: Text('Your request has been accepted.'),
      trailing: Text('10:00 AM'),
      // title: Text(notification.title),
      // subtitle: Text(notification.message),
      // trailing: Text(notification.timestamp),
      onTap: () {
        // Handle notification tap
      },
    );
  }
}
