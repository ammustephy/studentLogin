import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaidFeeDetailPage extends StatelessWidget {
  final Map<String, dynamic> fee;
  final String category;
  const PaidFeeDetailPage(this.fee, this.category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd MMM yyyy').format(DateTime.parse(fee['date']));
    return Scaffold(
      appBar: AppBar(title: Text('$category - Paid Details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Amount Paid: ₹${fee['amount']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Paid on: $date', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Text('Status: Paid', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
