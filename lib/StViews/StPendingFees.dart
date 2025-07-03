import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PendingFeeDetailPage extends StatelessWidget {
  final Map<String, dynamic> fee;
  final String category;
  const PendingFeeDetailPage(this.fee, this.category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final due = DateFormat('dd MMM yyyy').format(DateTime.parse(fee['dueDate']));
    return Scaffold(
      appBar: AppBar(title: Text('$category - Pending Details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Amount Due: ₹${fee['amount']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Due Date: $due', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Starting payment…')));
              },
              child: const Text('Pay Online'),
            ),
          ],
        ),
      ),
    );
  }
}
