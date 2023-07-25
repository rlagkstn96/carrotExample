import 'package:flutter/material.dart';

class TestDetailPage extends StatelessWidget {
  const TestDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ListTile Hero')),
      body: Center(
        child: Hero(
          tag: 'ListTile-Hero',
          child: Material(
            child: ListTile(
              title: const Text('ListTile with Hero'),
              subtitle: const Text('Tap here to go back'),
              tileColor: Colors.blue[700],
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
