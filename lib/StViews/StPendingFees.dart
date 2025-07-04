import 'package:flutter/material.dart';

class PendingFeeDetailPage extends StatelessWidget {
  final Map<String, dynamic> fee;
  const PendingFeeDetailPage({Key? key, required this.fee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text('Pending Fee Details',style: TextStyle(color: Colors.white),)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        Text('Due Date: ${fee['dueDate']}', style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
              Text(
                'Amount: ${fee['amount'].toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: 80,),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),),
              child: const Text('Pay Online',style: TextStyle(color: Colors.white),),
              onPressed: () {
                // TODO: implement payment flow
              },
            ),
          ),
          ],
        ),
      ),
    );
    }
  }
