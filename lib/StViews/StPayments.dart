import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'StPaidFees.dart';
import 'StPendingFees.dart';

class OnlinePaymentPage extends StatelessWidget {
  const OnlinePaymentPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> paidFees = const [
    {'heading': 'Academic fee', 'date': '2025-01-15', 'amount': 1500.0},
    {'heading': 'Bus fee', 'date': '2025-02-15', 'amount': 500.0},
    {'heading': 'PTA Fund', 'date': '2025-03-15', 'amount': 250.0},
  ];

  final List<Map<String, dynamic>> pendingFees = const [
    {'heading': 'Academic fee', 'dueDate': '2025-04-30', 'amount': 2000.0},
    {'heading': 'Bus fee', 'dueDate': '2025-05-31', 'amount': 500.0},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
          title: const Text('Fees Overview',style: TextStyle(color: Colors.white),)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Paid Fees', style: TextStyle(fontSize: 18)),
            Expanded(child: buildPaidList(context)),
            const Divider(height: 32, thickness: 2),
            Text('Pending Fees', style: TextStyle(fontSize: 18)),
            Expanded(child: buildPendingList(context)),
          ],
        ),
      ),
    );
  }

  Widget buildPaidList(BuildContext ctx) {
    return ListView.builder(
      itemCount: paidFees.length,
      itemBuilder: (_, i) {
        final fee = paidFees[i];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            visualDensity: const VisualDensity(vertical: -2),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fee['heading'],
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.green),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('MMM d, yyyy')
                      .format(DateTime.parse(fee['date'])),
                  style: const TextStyle(fontSize: 11),
                ),
              ],
            ),
            trailing: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${fee['amount'].toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                    onPressed: () {
                      Navigator.push(
                        ctx,
                        MaterialPageRoute(
                          builder: (_) => PaidFeeDetailPage(fee: fee),
                        ),
                      );
                    },
                    child: const Text('View',style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildPendingList(BuildContext ctx) {
    return ListView.builder(
      itemCount: pendingFees.length,
      itemBuilder: (_, i) {
        final fee = pendingFees[i];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            visualDensity: const VisualDensity(vertical: -2),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fee['heading'],
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.orange),
                ),
                const SizedBox(height: 4),
                Text(
                  'Due ${DateFormat('MMM d, yyyy').format(DateTime.parse(fee['dueDate']))}',
                  style: const TextStyle(fontSize: 11),
                ),
              ],
            ),
            trailing: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${fee['amount'].toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                    onPressed: () {
                      Navigator.push(
                        ctx,
                        MaterialPageRoute(
                          builder: (_) => PendingFeeDetailPage(fee: fee),
                        ),
                      );
                    },
                    child: const Text('View',style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
