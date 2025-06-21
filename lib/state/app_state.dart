import 'package:flutter/cupertino.dart';
import '../models/user.dart';
import '../models/task.dart';

class AppState extends StatefulWidget {
  final Widget child;
  const AppState({super.key, required this.child});

  static _AppStateScope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_AppStateScope>()!;
  }

  @override
  State<AppState> createState() => _AppStateState();
}

class _AppStateState extends State<AppState> {
  final List<User> _users = [];
  final List<Task> _tasks = [];

  void addUser(User user) {
    setState(() => _users.add(user));
  }

  void addTask(Task task) {
    setState(() => _tasks.add(task));
  }

  void clear() {
    setState(() {
      _users.clear();
      _tasks.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _AppStateScope(
      users: _users,
      tasks: _tasks,
      addUser: addUser,
      addTask: addTask,
      clear: clear,
      child: widget.child,
    );
  }
}

class _AppStateScope extends InheritedWidget {
  final List<User> users;
  final List<Task> tasks;
  final void Function(User) addUser;
  final void Function(Task) addTask;
  final void Function() clear;

  const _AppStateScope({
    required super.child,
    required this.users,
    required this.tasks,
    required this.addUser,
    required this.addTask,
    required this.clear,
  });

  @override
  bool updateShouldNotify(_AppStateScope oldWidget) =>
      users.length != oldWidget.users.length ||
      tasks.length != oldWidget.tasks.length;
}