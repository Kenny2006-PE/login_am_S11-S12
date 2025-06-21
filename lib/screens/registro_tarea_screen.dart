import 'package:flutter/cupertino.dart';
import '../widgets/cupertino_list_tile.dart';
import '../validators.dart';

class RegistroTareaScreen extends StatefulWidget {
  @override
  State<RegistroTareaScreen> createState() => _RegistroTareaScreenState();
}

class _RegistroTareaScreenState extends State<RegistroTareaScreen> {
  final TextEditingController tareaController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  DateTime selectedDate = DateTime.now().add(Duration(days: 1));
  String selectedPriority = 'Media';
  bool _isLoading = false;

  final List<String> priorities = ['Baja', 'Media', 'Alta'];

  void _showDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 300,
        decoration: BoxDecoration(
          color: CupertinoColors.systemBackground.resolveFrom(context),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: CupertinoColors.separator,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: Text('Cancelar'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    'Fecha de Vencimiento',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CupertinoButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: selectedDate,
                minimumDate: DateTime.now(),
                onDateTimeChanged: (date) {
                  setState(() => selectedDate = date);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPriorityPicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 300,
        decoration: BoxDecoration(
          color: CupertinoColors.systemBackground.resolveFrom(context),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: CupertinoColors.separator,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: Text('Cancelar'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    'Prioridad',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CupertinoButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoPicker(
                itemExtent: 44,
                onSelectedItemChanged: (index) {
                  setState(() => selectedPriority = priorities[index]);
                },
                children: priorities.map((priority) => Center(child: Text(priority))).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleRegister() async {
    // Validar título
    if (tareaController.text.trim().isEmpty) {
      _showAlert('Error', 'Por favor ingresa el título de la tarea');
      return;
    }

    if (tareaController.text.length > 100) {
      _showAlert('Error', 'El título de la tarea no puede exceder los 100 caracteres');
      return;
    }

    // Validar descripción (opcional pero con límite si se proporciona)
    if (descripcionController.text.length > 500) {
      _showAlert('Error', 'La descripción no puede exceder los 500 caracteres');
      return;
    }

    // Validar fecha
    if (selectedDate.isBefore(DateTime.now())) {
      _showAlert('Error', 'La fecha de vencimiento no puede ser anterior a la fecha actual');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Simular proceso de registro
      await Future.delayed(Duration(seconds: 1));

      setState(() => _isLoading = false);

      _showAlert('Éxito', 'Tarea creada correctamente', onOk: () async {
        await Future.delayed(Duration(milliseconds: 200));
        Navigator.pop(context);
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showAlert('Error', 'Ocurrió un error al crear la tarea. Por favor intenta nuevamente');
    }
  }

  void _showAlert(String title, String message, {VoidCallback? onOk}) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: Text('OK'),
            onPressed: () {
              Navigator.pop(context);
              if (onOk != null) onOk();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterCounter(TextEditingController controller, int maxLength) {
    return Padding(
      padding: EdgeInsets.only(top: 4, right: 8),
      child: Text(
        '${controller.text.length}/$maxLength',
        style: TextStyle(
          color: controller.text.length > maxLength
              ? CupertinoColors.systemRed
              : CupertinoColors.secondaryLabel,
          fontSize: 12,
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'Alta':
        return CupertinoColors.systemRed;
      case 'Media':
        return CupertinoColors.systemOrange;
      case 'Baja':
        return CupertinoColors.systemGreen;
      default:
        return CupertinoColors.systemBlue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text('Nueva Tarea'),
        previousPageTitle: 'Menú',
        backgroundColor: CupertinoColors.systemBackground,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              Text(
                'Detalles de la Tarea',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: CupertinoColors.label,
                ),
              ),
              SizedBox(height: 16),
              // Formulario de tarea
              Container(
                decoration: BoxDecoration(
                  color: CupertinoColors.systemBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CupertinoTextField(
                      controller: tareaController,
                      placeholder: 'Título de la tarea',
                      padding: EdgeInsets.all(16),
                      onChanged: (value) => setState(() {}),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: CupertinoColors.separator,
                            width: 0.5,
                          ),
                        ),
                      ),
                      prefix: Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Icon(
                          CupertinoIcons.textformat,
                          color: CupertinoColors.secondaryLabel,
                        ),
                      ),
                    ),
                    _buildCharacterCounter(tareaController, 100),
                    CupertinoTextField(
                      controller: descripcionController,
                      placeholder: 'Descripción (opcional)',
                      maxLines: 3,
                      padding: EdgeInsets.all(16),
                      onChanged: (value) => setState(() {}),
                      decoration: BoxDecoration(),
                      prefix: Padding(
                        padding: EdgeInsets.only(left: 16, top: 16),
                        child: Icon(
                          CupertinoIcons.doc_text,
                          color: CupertinoColors.secondaryLabel,
                        ),
                      ),
                    ),
                    _buildCharacterCounter(descripcionController, 500),
                  ],
                ),
              ),
              SizedBox(height: 24),
              // Configuraciones adicionales
              Container(
                decoration: BoxDecoration(
                  color: CupertinoColors.systemBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    CupertinoListTile(
                      leading: Icon(
                        CupertinoIcons.calendar,
                        color: CupertinoColors.activeBlue,
                      ),
                      title: Text('Fecha de Vencimiento'),
                      subtitle: Text(
                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                        style: TextStyle(
                          color: CupertinoColors.activeBlue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(
                        CupertinoIcons.chevron_right,
                        color: CupertinoColors.secondaryLabel,
                        size: 16,
                      ),
                      onTap: () => _showDatePicker(context),
                    ),
                    Container(
                      height: 0.5,
                      color: CupertinoColors.separator,
                      margin: EdgeInsets.only(left: 60),
                    ),
                    CupertinoListTile(
                      leading: Icon(
                        CupertinoIcons.flag,
                        color: _getPriorityColor(selectedPriority),
                      ),
                      title: Text('Prioridad'),
                      subtitle: Text(
                        selectedPriority,
                        style: TextStyle(
                          color: _getPriorityColor(selectedPriority),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(
                        CupertinoIcons.chevron_right,
                        color: CupertinoColors.secondaryLabel,
                        size: 16,
                      ),
                      onTap: _showPriorityPicker,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 48),
              // Botón de registro
              Container(
                width: double.infinity,
                height: 50,
                child: CupertinoButton.filled(
                  borderRadius: BorderRadius.circular(12),
                  child: _isLoading
                      ? CupertinoActivityIndicator(color: CupertinoColors.white)
                      : Text(
                          'Crear Tarea',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                  onPressed: _isLoading ? null : _handleRegister,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}