import 'package:flutter/material.dart';

class PaidFeeDetailPage extends StatelessWidget {
  final Map<String, dynamic> fee;
  const PaidFeeDetailPage({Key? key, required this.fee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
            title: const Text('Paid Fee Details', style: TextStyle(color: Colors.white),)),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          Text('Date: ${fee['date']}', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
                Text(
                  'Amount: ${fee['amount'].toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16),
                ),
            SizedBox(height: 80,),
            Center(
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),),
                icon: const Icon(Icons.print,color: Colors.white,),
                label: const Text('Print Receipt',style: TextStyle(color: Colors.white),),
                onPressed: () {
                  // TODO: implement print logic
                },
              ),
            ),
            ],
          ),
        )
    );
    }
  }
