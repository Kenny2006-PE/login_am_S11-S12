import 'package:flutter/cupertino.dart';
import 'screens/login_screen.dart';
import 'state/app_state.dart';

void main() {
  runApp(const AppState(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager iOS',
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.activeBlue,
        barBackgroundColor: CupertinoColors.systemGrey6,
      ),
      home: LoginScreen(),
    );
  }
}