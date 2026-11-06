import 'package:flutter/material.dart';

class MisionesScreen extends StatelessWidget {
  const MisionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Misiones')),
      body: const Center(child: Text('Misiones - pendiente')),
    );
  }
}
