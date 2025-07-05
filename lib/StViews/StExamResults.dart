import 'package:flutter/material.dart';

class ExamResultsPage extends StatelessWidget {
  const ExamResultsPage({Key? key}) : super(key: key);

  final Map<String, List<Map<String, String>>> _groupedResults = const {
    'Assignment Exam Result': [
      {'subject': 'Mathematics', 'score': '88', 'status': 'Passed', 'grade': 'A−'},
      {'subject': 'Physics', 'score': '79', 'status': 'Passed', 'grade': 'B+'},
    ],
    'Class Test Result': [
      {'subject': 'Chemistry', 'score': '72', 'status': 'Passed', 'grade': 'B'},
      {'subject': 'Biology', 'score': '66', 'status': 'Passed', 'grade': 'B−'},
      {'subject': 'History', 'score': '55', 'status': 'Passed', 'grade': 'C'},
    ],
    'Annual Exam Result': [
      {'subject': 'Mathematics', 'score': '92', 'status': 'Passed', 'grade': 'A'},
      {'subject': 'Physics', 'score': '85', 'status': 'Passed', 'grade': 'A−'},
      {'subject': 'Chemistry', 'score': '78', 'status': 'Passed', 'grade': 'B+'},
      {'subject': 'Biology', 'score': '68', 'status': 'Passed', 'grade': 'B−'},
      {'subject': 'Computer Science', 'score': '95', 'status': 'Passed', 'grade': 'A+'},
      {'subject': 'History', 'score': '54', 'status': 'Passed', 'grade': 'C'},
      {'subject': 'Geography', 'score': '48', 'status': 'Failed', 'grade': 'F'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final examTypes = _groupedResults.keys.toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Exam Results', style: TextStyle(color: Colors.white)),
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
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                child: const Text('View',style: TextStyle(color: Colors.white),),
                onPressed: () {
                  final results = _groupedResults[examType]!;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ExamDetailPage(
                        examType: examType,
                        results: results,
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

class ExamDetailPage extends StatelessWidget {
  final String examType;
  final List<Map<String, String>> results;

  const ExamDetailPage({Key? key, required this.examType, required this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(examType,style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.indigo,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: results.length,
        separatorBuilder: (_, __) => const Divider(height: 1, color: Colors.grey),
        itemBuilder: (context, index) {
          final result = results[index];
          final passed = result['status'] == 'Passed';
          return ListTile(
            leading: Icon(passed ? Icons.check_circle : Icons.error, color: passed ? Colors.green : Colors.red),
            title: Text(result['subject']!, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text('Score: ${result['score']} — Grade: ${result['grade']}'),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
              child: const Text('View',style: TextStyle(color: Colors.white),),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('${result['subject']} - $examType'),
                    content: Text(
                      'Subject: ${result['subject']}\n'
                          'Score: ${result['score']}\n'
                          'Grade: ${result['grade']}\n'
                          'Status: ${result['status']}',
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}