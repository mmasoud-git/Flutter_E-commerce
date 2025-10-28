import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../models/user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final User? u = auth.user;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: u == null
          ? const Center(child: Text('Not logged in'))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Name: ${u.name}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('Email: ${u.email}'),
                const SizedBox(height: 24),
                ElevatedButton(
                    onPressed: () => auth.logout().then((_) {
                          Navigator.pushReplacementNamed(context, '/login');
                        }),
                    child: const Text('Logout'))
              ]),
            ),
    );
  }
}