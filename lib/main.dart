import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'pages/homepage.dart';

void main() async {
  // Initialize Hive using the path we want to store the db in
  await Hive.initFlutter('/home/sarvesh/dev/projects/quicktask/lib/dbhive/');

  // Open the box
  final box = await Hive.openBox('myBox');

  print('Hive box path: ${box.path}');
  print('Box contains: ${box.length} keys');

  runApp(MyApp(box: box));
}

class MyApp extends StatefulWidget {
  final Box box;

  const MyApp({super.key, required this.box});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  void toggleTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickTask',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(box: widget.box, onThemeToggle: toggleTheme),
    );
  }
}
