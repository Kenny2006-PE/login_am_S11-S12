import 'package:flutter/cupertino.dart';
import '../validators.dart';
import '../widgets/cupertino_list_tile.dart';

class RegistroUsuarioScreen extends StatefulWidget {
  @override
  State<RegistroUsuarioScreen> createState() => _RegistroUsuarioScreenState();
}

class _RegistroUsuarioScreenState extends State<RegistroUsuarioScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  DateTime selectedDate = DateTime.now().subtract(Duration(days: 365 * 18));
  bool _isLoading = false;

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
                    'Seleccionar Fecha',
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
                maximumDate: DateTime.now(),
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

  Future<void> _handleRegister() async {
    // Validar nombre
    if (nameController.text.isEmpty) {
      _showAlert('Error', 'Por favor ingresa tu nombre completo');
      return;
    }

    if (!Validators.isValidName(nameController.text)) {
      _showAlert('Error', 'El nombre solo debe contener letras y espacios, y tener al menos 3 caracteres');
      return;
    }

    // Validar email
    if (emailController.text.isEmpty) {
      _showAlert('Error', 'Por favor ingresa tu correo electrónico');
      return;
    }

    if (!Validators.isValidEmail(emailController.text)) {
      _showAlert('Error', 'Por favor ingresa un correo electrónico válido');
      return;
    }

    // Validar fecha de nacimiento
    if (!Validators.isValidDate(selectedDate)) {
      _showAlert('Error', 'La edad debe estar entre 16 y 100 años');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Simular proceso de registro
      await Future.delayed(Duration(seconds: 1));

      setState(() => _isLoading = false);

      _showAlert('Éxito', 'Usuario registrado correctamente', onOk: () {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showAlert('Error', 'Ocurrió un error al registrar el usuario. Por favor intenta nuevamente');
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

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text('Registro Usuario'),
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
                'Información Personal',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: CupertinoColors.label,
                ),
              ),
              SizedBox(height: 16),
              // Formulario mejorado
              Container(
                decoration: BoxDecoration(
                  color: CupertinoColors.systemBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CupertinoTextField(
                      controller: nameController,
                      placeholder: 'Nombre completo',
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
                          CupertinoIcons.person,
                          color: CupertinoColors.secondaryLabel,
                        ),
                      ),
                    ),
                    _buildCharacterCounter(nameController, 50),
                    CupertinoTextField(
                      controller: emailController,
                      placeholder: 'Correo electrónico',
                      keyboardType: TextInputType.emailAddress,
                      padding: EdgeInsets.all(16),
                      onChanged: (value) => setState(() {}),
                      decoration: BoxDecoration(),
                      prefix: Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Icon(
                          CupertinoIcons.mail,
                          color: CupertinoColors.secondaryLabel,
                        ),
                      ),
                    ),
                    _buildCharacterCounter(emailController, 50),
                  ],
                ),
              ),
              SizedBox(height: 24),
              // Selector de fecha mejorado
              Container(
                decoration: BoxDecoration(
                  color: CupertinoColors.systemBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CupertinoListTile(
                  leading: Icon(
                    CupertinoIcons.calendar,
                    color: CupertinoColors.activeBlue,
                  ),
                  title: Text('Fecha de Nacimiento'),
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
                          'Registrar Usuario',
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