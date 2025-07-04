import 'package:flutter/material.dart';

class OnlineClassroomPage extends StatelessWidget {
  const OnlineClassroomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Online Classroom',style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                leading: const Icon(Icons.video_call, size: 48, color: Colors.indigo),
                title: const Text('Join Live Class', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                subtitle: const Text('Start your scheduled online session now'),
                trailing: ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward,color: Colors.white,),
                  label: const Text('Join',style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    // TODO: integrate your video SDK or routing to live class
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Joining live class...')),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Center(
                child: Text(
                  'No upcoming classes.\nCheck your schedule or class details.',
                  textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
