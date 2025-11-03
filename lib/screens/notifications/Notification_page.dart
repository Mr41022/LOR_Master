import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPage extends StatelessWidget {
  final String userRole;

  const NotificationPage({  
    Key? key,
    required this.userRole,
  }) : super(key: key);

  List<Map<String, String>> getNotificationsForRole() {
    switch (userRole.toLowerCase()) {
      case 'student':
        return [
          {
            'title': 'Transcript Request Update',
            'message': 'Your transcript request has been approved',
            'time': '2 hours ago'
          },
          {
            'title': 'New Assignment',
            'message': 'New assignment posted in Flutter course',
            'time': '1 day ago'
          },
        ];
      case 'examcell':
        return [
          {
            'title': 'New Transcript Request',
            'message': 'Student ID 2019BCS001 requested transcript',
            'time': '1 hour ago'
          },
          {
            'title': 'Pending Approvals',
            'message': '5 transcript requests pending review',
            'time': '3 hours ago'
          },
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifications = getNotificationsForRole();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(
            fontFamily: GoogleFonts.inter().fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: notifications.isEmpty
          ? Center(
              child: Text('No notifications'),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.notifications, color: Colors.white),
                    ),
                    title: Text(
                      notification['title']!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notification['message']!),
                        SizedBox(height: 4),
                        Text(
                          notification['time']!,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Handle notification tap
                    },
                  ),
                );
              },
            ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:major_project/widgets/notification_tile.dart';

// class NotificationPage extends StatelessWidget {
//   final String userRole;

//   const NotificationPage({Key? key, required this.userRole}) : super(key: key);
  

//   Stream<List<Notification>> getNotificationsForRole(String role) {
//     // Connect to your data source (Firestore, API etc)
//   //   return FirebaseFirestore.instance
//   //       .collection('notifications')
//   //       .where('targetRole', isEqualTo: role)
//   //       .snapshots()
//   //       .map((snapshot) => snapshot.docs
//   //           .map((doc) => Notification.fromJson(doc.data()))
//   //           .toList());
//     // Placeholder return statement
//     return Stream.value([

//       Notification(
//         title: 'Notification 1',
//         message: 'This is the first notification',
//         timestamp: '2023-05-28 10:00 AM',
//         targetRole: 'professor',
//       ),

//       Notification(
//         title: 'Notification 2',
//         message: 'This is the second notification',
//         timestamp: '2023-05-28 11:00 AM',
//         targetRole: 'professor',
//       ),
//       // Add more notifications as needed
//     ]);

//   }  Widget build(BuildContext context) {
//     return StreamBuilder<List<Notification>>(
//       stream: getNotificationsForRole(userRole),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return ListView.builder(
//             itemCount: 5,
//             itemBuilder: (context, index) {
//               final notification = snapshot.data![index];
//               return NotificationTile(notification: notification);
//             }
//           );
//         }
//         return Center(child: CircularProgressIndicator());
//       }
//     );
//   }
// }