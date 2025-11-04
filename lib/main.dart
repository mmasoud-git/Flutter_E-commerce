import 'package:flutter/material.dart';
import 'package:flutter_demo_ecommerce/screens/product_list_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'njection/dependency_injection.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(); // from dependency_injection.dart
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo E-commerce Refactor',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const ProductListScreen(),
    );
  }
}
