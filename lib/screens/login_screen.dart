import 'package:flutter/cupertino.dart';
import 'menu_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  bool _loading = false;

  void _login() {
    setState(() => _loading = true);
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() => _loading = false);
      if (_userController.text.isNotEmpty && _passController.text.isNotEmpty) {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (_) => const MenuScreen()),
        );
      } else {
        showCupertinoDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
            title: const Text('Error'),
            content: const Text('Por favor, llena todos los campos.'),
            actions: [
              CupertinoDialogAction(child: const Text('OK'), onPressed: () => Navigator.pop(context))
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(26),
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.systemGrey.withOpacity(0.16),
                blurRadius: 18,
                offset: const Offset(0, 7),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 18),
                child: Icon(CupertinoIcons.person_alt_circle, size: 80, color: CupertinoColors.activeBlue),
              ),
              Text(
                'Bienvenido',
                style: theme.textTheme.navTitleTextStyle.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 28),
              CupertinoTextField(
                controller: _userController,
                placeholder: 'Usuario',
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(CupertinoIcons.person, color: CupertinoColors.systemGrey2),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
              ),
              const SizedBox(height: 18),
              CupertinoTextField(
                controller: _passController,
                placeholder: 'Contraseña',
                obscureText: true,
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(CupertinoIcons.lock, color: CupertinoColors.systemGrey2),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  borderRadius: BorderRadius.circular(14),
                  onPressed: _loading ? null : _login,
                  child: _loading
                      ? const CupertinoActivityIndicator()
                      : const Text('Iniciar Sesión'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}