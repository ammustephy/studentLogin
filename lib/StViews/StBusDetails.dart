// lib/models/bus_route.dart
import 'package:flutter/material.dart';

class BusRoute {
  final String number;
  final String color;
  final String path;

  BusRoute({required this.number, required this.color, required this.path});
}

// Sample list of Thiruvananthapuram City Circular routes (13 total) :contentReference[oaicite:0]{index=0}
final List<BusRoute> circularRoutes = [
  BusRoute(
    number: '1A',
    color: 'Red Circle',
    path:
    'East Fort → Overbridge → Thampanoor → Ayurveda College → Spencer → Palayam → PMG → Museum → Kanakakunnu → Manaveeyam Road → Police HQ → Vazhuthakkad → Thycaud → Flyover → Thampanoor → East Fort',
  ),
  BusRoute(
    number: '2A',
    color: 'Blue Circle',
    path:
    'East Fort → Overbridge → Thampanoor → General Hospital → Kerala University → Palayam → Legislature → Museum → Vellayambalam → Shastamangalam → … → East Fort',
  ),
  BusRoute(
    number: '3A',
    color: 'Green Circle',
    path:
    'East Fort → Overbridge → Thampanoor → Ayurveda College → Spencer → Palayam → PMG → Museum → Kanakakunnu → Manaveeyam Road → Police HQ → Vazhuthakkad → Thycaud → Flyover → Thampanoor → East Fort',
  ),
  // Add other routes...
];

class BusDetailsPage extends StatelessWidget {
  final BusRoute route;

  const BusDetailsPage({Key? key, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.indigo,
      title: Text('Route ${route.number} (${route.color})', style: const TextStyle(color: Colors.white)),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Route Number: ${route.number}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Color: ${route.color}', style: const TextStyle(fontSize: 16)),
          const Divider(height: 24, color: Colors.grey),
          const Text('Route:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Expanded(child: SingleChildScrollView(child: Text(route.path, style: const TextStyle(fontSize: 14)))),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // TODO: Show timetable/map
              },
              child: const Text('View Time'),
            ),
          ),
        ],
      ),
    ),
  );
}

class BusListPage extends StatelessWidget {
  const BusListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Circular Bus Routes')),
      body: ListView.builder(
        itemCount: circularRoutes.length,
        itemBuilder: (ctx, i) {
          final r = circularRoutes[i];
          return ListTile(
            leading: CircleAvatar(child: Text(r.number.split(' ')[0])),
            title: Text('Route ${r.number} (${r.color})'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => BusDetailsPage(route: r)),
            ),
          );
        },
      ),
    );
  }
}

