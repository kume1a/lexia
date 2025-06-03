import 'package:flutter/material.dart';

import '../app/navigation/routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return _Content();
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to the Profile Page!'),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, Routes.settings),
              child: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
