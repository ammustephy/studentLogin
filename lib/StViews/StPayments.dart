// lib/Pages/OnlinePaymentPage.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OnlinePaymentPage extends StatelessWidget {
  const OnlinePaymentPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> paidFees = const [
    {'date': '2025-01-15', 'amount': 150.0},
    {'date': '2025-02-15', 'amount': 150.0},
    {'date': '2025-03-15', 'amount': 150.0},
  ];

  final List<Map<String, dynamic>> pendingFees = const [
    {'dueDate': '2025-04-30', 'amount': 200.0},
    {'dueDate': '2025-05-31', 'amount': 200.0},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fees Overview')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Paid Fees', style: Theme.of(context).textTheme.titleLarge),
            Expanded(
              child: ListView.builder(
                itemCount: paidFees.length,
                itemBuilder: (_, i) {
                  final item = paidFees[i];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(Icons.check_circle, color: Colors.green),
                      title: Text(
                        '\$${item['amount'].toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        DateFormat('MMM d, yyyy').format(DateTime.parse(item['date'])),
                      ),
                    ),
                  );
                },
              ),
            ),

            Divider(height: 32, thickness: 2),

            Text('Pending Fees', style: Theme.of(context).textTheme.titleLarge),
            Expanded(
              child: ListView.builder(
                itemCount: pendingFees.length,
                itemBuilder: (_, i) {
                  final item = pendingFees[i];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(Icons.pending_actions, color: Colors.orange),
                      title: Text(
                        '\$${item['amount'].toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Due: ${DateFormat('MMM d, yyyy').format(DateTime.parse(item['dueDate']))}',
                      ),
                      trailing: ElevatedButton(
                        child: const Text('Pay'),
                        onPressed: () {
                          // TODO: launch payment flow
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}