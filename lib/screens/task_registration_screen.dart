import 'package:flutter/cupertino.dart';
import '../models/task.dart';
import '../state/app_state.dart';

class TaskRegistrationScreen extends StatefulWidget {
  const TaskRegistrationScreen({super.key});

  @override
  State<TaskRegistrationScreen> createState() => _TaskRegistrationScreenState();
}

class _TaskRegistrationScreenState extends State<TaskRegistrationScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  DateTime _date = DateTime.now();

  void _showDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 290,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: CupertinoButton(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                initialDateTime: _date,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (d) => setState(() => _date = d),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _registerTask() {
    if (_titleController.text.isEmpty || _descController.text.isEmpty) {
      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text('Error'),
          content: const Text('Completa todos los campos.'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      );
      return;
    }
    final task = Task(
      title: _titleController.text,
      description: _descController.text,
      dueDate: _date,
    );
    AppState.of(context).addTask(task);

    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Éxito'),
        content: const Text('Tarea registrada correctamente.'),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () {
              Navigator.pop(context);
              _titleController.clear();
              _descController.clear();
              setState(() => _date = DateTime.now());
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Registro de Tareas')),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(28),
          children: [
            CupertinoTextField(
              controller: _titleController,
              placeholder: 'Título de la tarea',
              prefix: const Icon(CupertinoIcons.pencil, color: CupertinoColors.systemGrey2),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
            ),
            const SizedBox(height: 18),
            CupertinoTextField(
              controller: _descController,
              placeholder: 'Descripción',
              prefix: const Icon(CupertinoIcons.text_alignleft, color: CupertinoColors.systemGrey2),
              maxLines: 3,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
            ),
            const SizedBox(height: 18),
            CupertinoButton(
              color: CupertinoColors.systemGrey5,
              borderRadius: BorderRadius.circular(12),
              onPressed: _showDatePicker,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(CupertinoIcons.calendar, size: 20),
                  const SizedBox(width: 7),
                  Text('Fecha: ${_date.toString().split(' ')[0]}'),
                ],
              ),
            ),
            const SizedBox(height: 26),
            SizedBox(
              width: double.infinity,
              child: CupertinoButton.filled(
                borderRadius: BorderRadius.circular(14),
                onPressed: _registerTask,
                child: const Text('Registrar Tarea'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}