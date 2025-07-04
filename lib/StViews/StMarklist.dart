import 'package:flutter/material.dart';

class MarklistPage extends StatelessWidget {
  MarklistPage({Key? key}) : super(key: key);

  // Simulated grouped marklists data as map: exam type -> list of marks
  final Map<String, List<Map<String, dynamic>>> groupedMarklists = {
    'Assignment Exam Marklist': [
      {'subject': 'Mathematics', 'marks': 88, 'grade': 'A−'},
      {'subject': 'Physics', 'marks': 79, 'grade': 'B+'},
      {'subject': 'Chemistry', 'marks': 75, 'grade': 'B'},
    ],
    'Class Test Marklist': [
      {'subject': 'Biology', 'marks': 68, 'grade': 'B−'},
      {'subject': 'History', 'marks': 54, 'grade': 'C'},
      {'subject': 'Geography', 'marks': 48, 'grade': 'D'},
    ],
    'Annual Exam Marklist': [
      {'subject': 'Mathematics', 'marks': 92, 'grade': 'A'},
      {'subject': 'Physics', 'marks': 85, 'grade': 'A−'},
      {'subject': 'Chemistry', 'marks': 78, 'grade': 'B+'},
      {'subject': 'Biology', 'marks': 68, 'grade': 'B−'},
      {'subject': 'Computer Science', 'marks': 95, 'grade': 'A+'},
      {'subject': 'History', 'marks': 54, 'grade': 'C'},
      {'subject': 'Geography', 'marks': 48, 'grade': 'D'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final examTypes = groupedMarklists.keys.toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Marklists', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        itemCount: examTypes.length,
        itemBuilder: (context, index) {
          final examType = examTypes[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 3,
            child: ListTile(
              title: Text(
                examType,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                child: const Text('View',style: TextStyle(color: Colors.white),),
                onPressed: () {
                  final marklist = groupedMarklists[examType]!;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MarklistDetailPage(
                        examType: examType,
                        marklist: marklist,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class MarklistDetailPage extends StatelessWidget {
  final String examType;
  final List<Map<String, dynamic>> marklist;

  const MarklistDetailPage(
      {Key? key, required this.examType, required this.marklist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(examType),
        backgroundColor: Colors.indigo,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: marklist.length,
        separatorBuilder: (_, __) => const Divider(height: 1, color: Colors.grey),
        itemBuilder: (context, index) {
          final entry = marklist[index];
          final int marks = entry['marks'] as int;
          final bool passed = marks >= 50;
          final color = passed ? Colors.green : Colors.red;

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Text(
                marks.toString(),
                style:
                TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            title: Text(
              entry['subject'] as String,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Grade: ${entry['grade']}'),
            trailing: Text(
              passed ? 'Pass' : 'Fail',
              style: TextStyle(color: color, fontWeight: FontWeight.w600),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(entry['subject'] as String),
                  content: Text(
                    'You scored $marks marks with grade ${entry['grade']}.\n'
                        'Status: ${passed ? 'Pass' : 'Fail'}.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}