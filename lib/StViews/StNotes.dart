import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class NotesPage extends StatelessWidget {
  const NotesPage({Key? key}) : super(key: key);

  final List<Map<String, String>> _notes = const [
    {
      'title': 'Mathematics - Algebra Basics',
      'content': 'Learn about variables, constants, linear equations, and how to solve for x.'
    },
    {
      'title': 'Biology - Cell Structure',
      'content': 'Cells are the basic unit of life: discuss the nucleus, mitochondria, and cell membrane.'
    },
    // ... more notes ...
  ];

  Future<void> _downloadNote(BuildContext context, String title, String content) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/${title.replaceAll(' ', '_')}.txt');
      await file.writeAsString(content);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved to ${file.path}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving note: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Notes', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _notes.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final note = _notes[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.indigo.shade100),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.indigo.shade50,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              title: Text(
                note['title']!,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(note['content']!),
              trailing: IconButton(
                icon: const Icon(Icons.download, color: Colors.indigo),
                tooltip: 'Download Note',
                onPressed: () => _downloadNote(context, note['title']!, note['content']!),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(note['title']!),
                    content: Text(note['content']!),
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
