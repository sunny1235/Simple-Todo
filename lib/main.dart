import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/splash/splash_screen.dart';

void main() {
  runApp(const ProviderScope(child: AppFoundation()));
}


class AppFoundation extends StatelessWidget {
  const AppFoundation({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
