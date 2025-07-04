import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  // Dummy notifications data
  static final List<Map<String, String>> _dummyNotifications = [
    {
      'title': 'Payment Successful',
      'subtitle': 'Your tuition fee has been successfully processed.',
      'time': '2h ago',
    },
    {
      'title': 'New Message from Admin',
      'subtitle': 'Please check your inbox for updates.',
      'time': '5h ago',
    },
    {
      'title': 'Assignment Deadline',
      'subtitle': 'Don’t forget to submit your math assignment tomorrow.',
      'time': '1d ago',
    },
    {
      'title': 'Bus Delay Notice',
      'subtitle': 'Your bus route 15 is delayed by 10 mins.',
      'time': '2d ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView.separated(
        itemCount: _dummyNotifications.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final n = _dummyNotifications[index];
          return ListTile(
            leading: const Icon(Icons.notifications, color: Colors.indigo),
            title: Text(n['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(n['subtitle']!),
            trailing: Text(
              n['time']!,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            onTap: () {
              // Could show a detail or mark as read
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tapped "${n['title']}"')),
              );
            },
          );
        },
      ),
    );
  }
}
