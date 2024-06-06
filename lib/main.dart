import 'package:flutter/material.dart';
import 'package:paudspk/spkpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    app_load();
  }

  void app_load() async {
    Future.delayed(const Duration(seconds: 1), () async {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SpkpageWidget(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFFe0e3e7));
  }
}
