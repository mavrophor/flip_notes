import 'package:flip_notes/ui/grid/grid_screen.dart';
import 'package:flip_notes/utils/theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeDefault,
      darkTheme: themeDefaultDark,
      themeMode: ThemeMode.system,
      home: const GridScreen(),
    );
  }
}
