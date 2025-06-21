import 'package:flutter/cupertino.dart';
import 'user_registration_screen.dart';
import 'task_registration_screen.dart';
import 'task_list_screen.dart';
import 'user_list_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'title': 'Registro de Usuario',
        'icon': CupertinoIcons.person_add,
        'screen': const UserRegistrationScreen()
      },
      {
        'title': 'Ver Usuarios',
        'icon': CupertinoIcons.person_2,
        'screen': const UserListScreen()
      },
      {
        'title': 'Registro de Tareas',
        'icon': CupertinoIcons.add_circled,
        'screen': const TaskRegistrationScreen()
      },
      {
        'title': 'Listado de Tareas',
        'icon': CupertinoIcons.list_bullet,
        'screen': const TaskListScreen()
      },
    ];

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Menú Principal'),
      ),
      child: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 38, horizontal: 24),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, i) {
            final item = items[i];
            return CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (_) => item['screen'] as Widget),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemGrey.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Icon(item['icon'] as IconData, color: CupertinoColors.activeBlue, size: 28),
                    const SizedBox(width: 22),
                    Expanded(
                      child: Text(
                        item['title'] as String,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: CupertinoColors.black,
                        ),
                      ),
                    ),
                    const Icon(CupertinoIcons.right_chevron, color: CupertinoColors.inactiveGray),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}