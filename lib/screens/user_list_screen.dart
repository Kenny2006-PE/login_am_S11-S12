import 'package:flutter/cupertino.dart';
import '../state/app_state.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final users = AppState.of(context).users;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Usuarios Registrados'),
      ),
      child: SafeArea(
        child: users.isEmpty
            ? const Center(
                child: Text(
                  'No hay usuarios registrados',
                  style: TextStyle(fontSize: 18, color: CupertinoColors.systemGrey2),
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: users.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, i) {
                  final u = users[i];
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey6,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.person_crop_circle_fill, color: CupertinoColors.activeBlue, size: 34),
                        const SizedBox(width: 13),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(u.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
                              Text(u.email, style: const TextStyle(fontSize: 15, color: CupertinoColors.systemGrey)),
                              Text(
                                'Fecha: ${u.registrationDate.toString().split(' ')[0]}',
                                style: const TextStyle(fontSize: 13, color: CupertinoColors.systemGrey2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}