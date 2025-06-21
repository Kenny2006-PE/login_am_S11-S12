import 'package:flutter/cupertino.dart';
import '../state/app_state.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = AppState.of(context).tasks;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Listado de Tareas'),
      ),
      child: SafeArea(
        child: tasks.isEmpty
            ? const Center(
                child: Text(
                  'No hay tareas registradas',
                  style: TextStyle(fontSize: 18, color: CupertinoColors.systemGrey2),
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: tasks.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, i) {
                  final t = tasks[i];
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey6,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.check_mark_circled_solid, color: CupertinoColors.activeGreen, size: 34),
                        const SizedBox(width: 13),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(t.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
                              Text(t.description, style: const TextStyle(fontSize: 15, color: CupertinoColors.systemGrey)),
                              Text(
                                'Fecha: ${t.dueDate.toString().split(' ')[0]}',
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