import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtl = TextEditingController(text: 'johnd');
  final _passCtl = TextEditingController(text: 'm38rmF\$');
  bool autoLogin = true;

  @override
void initState() {
  super.initState();

  // Run after the first build frame to avoid setState() during build errors
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    await auth.tryAutoLogin();

    // If the user is already logged in, navigate safely after build
    if (auth.user != null && mounted) {
      Navigator.pushReplacementNamed(context, '/products');
    }
  });
}

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    if (auth.isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    if (auth.user != null) {
      Future.microtask(() => Navigator.pushReplacementNamed(context, '/products'));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _emailCtl, decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 8),
            TextField(controller: _passCtl, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            Row(
              children: [
                Checkbox(value: autoLogin, onChanged: (v) => setState(() => autoLogin = v ?? true)),
                const Text('Auto-login'),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                final ok = await auth.login(_emailCtl.text, _passCtl.text);
                if (ok && mounted) {
                  Navigator.pushReplacementNamed(context, '/products');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login failed')));
                }
              },
              child: const Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}