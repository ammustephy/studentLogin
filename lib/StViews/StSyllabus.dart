import 'package:flutter/material.dart';

class SyllabusPage extends StatelessWidget {
  SyllabusPage({Key? key}) : super(key: key);

  // Sample syllabus sections with dummy download URLs
  final List<Map<String, dynamic>> _syllabus = const [
    {
      'module': 'Module 1: Introduction to Computing',
      'topics': [
        'Overview of computing systems',
        'History of computers',
        'Digital citizenship and ethics',
      ],
      'downloadUrl': 'https://example.com/downloads/module1.pdf',
    },
    {
      'module': 'Module 2: Programming Fundamentals',
      'topics': [
        'Variables and data types',
        'Control flow: if‑else, loops',
        'Functions and modularity',
      ],
      'downloadUrl': 'https://example.com/downloads/module2.pdf',
    },
    {
      'module': 'Module 3: Data Structures & Algorithms',
      'topics': [
        'Arrays and lists',
        'Search and sort algorithms',
        'Basic recursion',
      ],
      'downloadUrl': 'https://example.com/downloads/module3.pdf',
    },
    {
      'module': 'Module 4: Web & App Design',
      'topics': [
        'HTML & CSS basics',
        'Intro to JavaScript',
        'Responsive design principles',
      ],
      'downloadUrl': 'https://example.com/downloads/module4.pdf',
    },
    {
      'module': 'Module 5: Final Project',
      'topics': [
        'Project planning and design',
        'Implementation and testing',
        'Presentation & documentation',
      ],
      'downloadUrl': 'https://example.com/downloads/module5.pdf',
    },
  ];

  // Stub function to simulate download
  Future<void> _downloadSyllabus(BuildContext context, String url, String moduleName) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloading "$moduleName"...')),
    );
    await Future.delayed(const Duration(seconds: 1));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Download of "$moduleName" completed!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Syllabus', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _syllabus.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, idx) {
          final module = _syllabus[idx];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white, // Light background
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        module['module'] as String,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.download, color: Colors.blue),
                      tooltip: 'Download syllabus',
                      onPressed: () => _downloadSyllabus(
                        context,
                        module['downloadUrl'] as String,
                        module['module'] as String,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ...List<Widget>.from(
                  (module['topics'] as List<String>).map(
                        (topic) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          const Icon(Icons.check, color: Colors.blue, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              topic,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
