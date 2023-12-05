import 'package:dot_and_box/launcher/launcher_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        appBarTheme:
            const AppBarTheme(color: Color.fromARGB(255, 173, 194, 205)),
      ),
      home: const LauncherView(),
    );
  }
}
