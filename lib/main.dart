import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'validators.dart';

void main() {
  runApp(MyCupertinoApp());
}

class MyCupertinoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Sección D',
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
        brightness: Brightness.light,
      ),
      home: LoginScreen(),
    );
  }
}

// LOGIN SCREEN MEJORADA
class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    if (userController.text.isEmpty || passController.text.isEmpty) {
      _showAlert('Error', 'Por favor completa todos los campos');
      return;
    }

    setState(() => _isLoading = true);

    // Simular proceso de login
    await Future.delayed(Duration(seconds: 1));

    setState(() => _isLoading = false);

    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (_) => MenuScreen()),
    );
  }

  void _showAlert(String title, String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(height: 60),

              // Logo/Icono de la app
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: CupertinoColors.activeBlue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  CupertinoIcons.person_crop_circle_fill,
                  size: 50,
                  color: CupertinoColors.white,
                ),
              ),

              SizedBox(height: 24),

              Text(
                'Bienvenido',
                style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
              ),

              SizedBox(height: 8),

              Text(
                'Ingresa tus credenciales para continuar',
                style: TextStyle(
                  color: CupertinoColors.secondaryLabel,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 48),

              // Campos de entrada mejorados
              Container(
                decoration: BoxDecoration(
                  color: CupertinoColors.systemBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    CupertinoTextField(
                      controller: userController,
                      placeholder: 'Usuario',
                      padding: EdgeInsets.all(16),
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
                    CupertinoTextField(
                      controller: passController,
                      placeholder: 'Contraseña',
                      obscureText: true,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(),
                      prefix: Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Icon(
                          CupertinoIcons.lock,
                          color: CupertinoColors.secondaryLabel,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32),

              // Botón de login mejorado
              Container(
                width: double.infinity,
                height: 50,
                child: CupertinoButton.filled(
                  borderRadius: BorderRadius.circular(12),
                  child: _isLoading
                      ? CupertinoActivityIndicator(color: CupertinoColors.white)
                      : Text(
                          'Ingresar',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                  onPressed: _isLoading ? null : _handleLogin,
                ),
              ),

              SizedBox(height: 24),

              CupertinoButton(
                child: Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(
                    color: CupertinoColors.activeBlue,
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  _showAlert('Información', 'Funcionalidad no implementada');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// MENÚ PRINCIPAL MEJORADO
class MenuScreen extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {
      'title': 'Registro Usuario',
      'subtitle': 'Agregar nuevo usuario al sistema',
      'icon': CupertinoIcons.person_add,
      'color': CupertinoColors.activeBlue,
      'route': RegistroUsuarioScreen(),
    },
    {
      'title': 'Registro Tareas',
      'subtitle': 'Crear una nueva tarea',
      'icon': CupertinoIcons.add_circled,
      'color': CupertinoColors.systemGreen,
      'route': RegistroTareaScreen(),
    },
    {
      'title': 'Listado Tareas',
      'subtitle': 'Ver todas las tareas registradas',
      'icon': CupertinoIcons.list_bullet,
      'color': CupertinoColors.systemOrange,
      'route': ListadoTareasScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text('Menú Principal'),
        backgroundColor: CupertinoColors.systemBackground,
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.gear),
          onPressed: () {
            // Configuraciones
          },
        ),
      ),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header con saludo
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            CupertinoColors.activeBlue,
                            CupertinoColors.activeBlue.withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '¡Hola!',
                            style: TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Administra tu sistema desde aquí',
                            style: TextStyle(
                              color: CupertinoColors.white.withOpacity(0.9),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24),

                    Text(
                      'Opciones disponibles',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: CupertinoColors.label,
                      ),
                    ),

                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Lista de opciones del menú
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = menuItems[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Container(
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CupertinoListTile(
                        leading: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: item['color'].withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            item['icon'],
                            color: item['color'],
                            size: 24,
                          ),
                        ),
                        title: Text(
                          item['title'],
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          item['subtitle'],
                          style: TextStyle(
                            color: CupertinoColors.secondaryLabel,
                            fontSize: 15,
                          ),
                        ),
                        trailing: Icon(
                          CupertinoIcons.chevron_right,
                          color: CupertinoColors.secondaryLabel,
                          size: 16,
                        ),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.push(
                            context,
                            CupertinoPageRoute(builder: (_) => item['route']),
                          );
                        },
                      ),
                    ),
                  );
                },
                childCount: menuItems.length,
              ),
            ),

            // Botón de cerrar sesión
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    SizedBox(height: 32),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: CupertinoButton(
                        color: CupertinoColors.systemRed,
                        borderRadius: BorderRadius.circular(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(CupertinoIcons.power, size: 18),
                            SizedBox(width: 8),
                            Text(
                              'Cerrar Sesión',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              title: Text('Cerrar Sesión'),
                              content: Text('¿Estás seguro de que deseas cerrar sesión?'),
                              actions: [
                                CupertinoDialogAction(
                                  child: Text('Cancelar'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                CupertinoDialogAction(
                                  isDestructiveAction: true,
                                  child: Text('Cerrar Sesión'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      CupertinoPageRoute(builder: (_) => LoginScreen()),
                                      (_) => false,
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// REGISTRO USUARIO MEJORADO
class RegistroUsuarioScreen extends StatefulWidget {
  @override
  State<RegistroUsuarioScreen> createState() => _RegistroUsuarioScreenState();
}

class _RegistroUsuarioScreenState extends State<RegistroUsuarioScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  DateTime selectedDate = DateTime.now();
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
    if (nameController.text.isEmpty || emailController.text.isEmpty) {
      _showAlert('Error', 'Por favor completa todos los campos');
      return;
    }

    setState(() => _isLoading = true);

    // Simular proceso de registro
    await Future.delayed(Duration(seconds: 1));

    setState(() => _isLoading = false);

    _showAlert('Éxito', 'Usuario registrado correctamente', onOk: () {
      Navigator.pop(context);
      Navigator.pop(context);
    });
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
                  children: [
                    CupertinoTextField(
                      controller: nameController,
                      placeholder: 'Nombre completo',
                      padding: EdgeInsets.all(16),
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
                    CupertinoTextField(
                      controller: emailController,
                      placeholder: 'Correo electrónico',
                      keyboardType: TextInputType.emailAddress,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(),
                      prefix: Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Icon(
                          CupertinoIcons.mail,
                          color: CupertinoColors.secondaryLabel,
                        ),
                      ),
                    ),
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
}

// LISTADO DE TAREAS MEJORADO
class ListadoTareasScreen extends StatefulWidget {
  @override
  State<ListadoTareasScreen> createState() => _ListadoTareasScreenState();
}

class _ListadoTareasScreenState extends State<ListadoTareasScreen> {
  final List<Map<String, dynamic>> tareas = [
    {
      'id': 1,
      'titulo': 'Revisar documentación del proyecto',
      'descripcion': 'Revisar y actualizar la documentación técnica del sistema',
      'fecha': DateTime(2025, 6, 25),
      'prioridad': 'Alta',
      'completada': false,
    },
    {
      'id': 2,
      'titulo': 'Reunión con equipo de desarrollo',
      'descripcion': 'Coordinar próximas funcionalidades',
      'fecha': DateTime(2025, 6, 23),
      'prioridad': 'Media',
      'completada': true,
    },
    {
      'id': 3,
      'titulo': 'Actualizar base de datos',
      'descripcion': 'Aplicar migraciones pendientes',
      'fecha': DateTime(2025, 6, 28),
      'prioridad': 'Alta',
      'completada': false,
    },
    {
      'id': 4,
      'titulo': 'Preparar presentación',
      'descripcion': 'Crear slides para la demo del cliente',
      'fecha': DateTime(2025, 6, 30),
      'prioridad': 'Baja',
      'completada': false,
    },
  ];

  String selectedFilter = 'Todas';
  final List<String> filters = ['Todas', 'Pendientes', 'Completadas'];

  List<Map<String, dynamic>> get filteredTareas {
    switch (selectedFilter) {
      case 'Pendientes':
        return tareas.where((t) => !t['completada']).toList();
      case 'Completadas':
        return tareas.where((t) => t['completada']).toList();
      default:
        return tareas;
    }
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      final actualIndex = tareas.indexWhere((t) => t['id'] == filteredTareas[index]['id']);
      tareas[actualIndex]['completada'] = !tareas[actualIndex]['completada'];
    });

    HapticFeedback.lightImpact();
  }

  void _showFilterOptions() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        title: Text('Filtrar tareas'),
        actions: filters
            .map((filter) => CupertinoActionSheetAction(
                  child: Text(filter),
                  onPressed: () {
                    setState(() => selectedFilter = filter);
                    Navigator.pop(context);
                  },
                ))
            .toList(),
        cancelButton: CupertinoActionSheetAction(
          child: Text('Cancelar'),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

  void _showTaskDetails(Map<String, dynamic> tarea) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: CupertinoColors.systemBackground.resolveFrom(context),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            // Header
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
                    child: Text('Cerrar'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    'Detalles de Tarea',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CupertinoButton(
                    child: Icon(CupertinoIcons.ellipsis),
                    onPressed: () {
                      // Más opciones
                    },
                  ),
                ],
              ),
            ),

            // Contenido
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Estado y prioridad
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: tarea['completada']
                                ? CupertinoColors.systemGreen.withOpacity(0.1)
                                : CupertinoColors.systemOrange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            tarea['completada'] ? 'Completada' : 'Pendiente',
                            style: TextStyle(
                              color: tarea['completada']
                                  ? CupertinoColors.systemGreen
                                  : CupertinoColors.systemOrange,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(tarea['prioridad']).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            'Prioridad ${tarea['prioridad']}',
                            style: TextStyle(
                              color: _getPriorityColor(tarea['prioridad']),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24),

                    // Título
                    Text(
                      tarea['titulo'],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.label,
                      ),
                    ),

                    SizedBox(height: 16),

                    // Descripción
                    if (tarea['descripcion'] != null && tarea['descripcion'].isNotEmpty) ...[
                      Text(
                        'Descripción',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: CupertinoColors.label,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        tarea['descripcion'],
                        style: TextStyle(
                          fontSize: 16,
                          color: CupertinoColors.secondaryLabel,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 24),
                    ],

                    // Fecha de vencimiento
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey6,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.calendar,
                            color: CupertinoColors.activeBlue,
                            size: 20,
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Fecha de vencimiento',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: CupertinoColors.secondaryLabel,
                                ),
                              ),
                              Text(
                                '${tarea['fecha'].day}/${tarea['fecha'].month}/${tarea['fecha'].year}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: CupertinoColors.label,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = filteredTareas;

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text('Mis Tareas'),
        previousPageTitle: 'Menú',
        backgroundColor: CupertinoColors.systemBackground,
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.slider_horizontal_3),
          onPressed: _showFilterOptions,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Header con estadísticas
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: CupertinoColors.systemBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatCard(
                    'Total',
                    tareas.length.toString(),
                    CupertinoColors.systemBlue,
                    CupertinoIcons.list_bullet,
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: CupertinoColors.separator,
                  ),
                  _buildStatCard(
                    'Pendientes',
                    tareas.where((t) => !t['completada']).length.toString(),
                    CupertinoColors.systemOrange,
                    CupertinoIcons.clock,
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: CupertinoColors.separator,
                  ),
                  _buildStatCard(
                    'Completadas',
                    tareas.where((t) => t['completada']).length.toString(),
                    CupertinoColors.systemGreen,
                    CupertinoIcons.checkmark_circle,
                  ),
                ],
              ),
            ),

            // Filtro actual
            if (selectedFilter != 'Todas')
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: CupertinoColors.activeBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      CupertinoIcons.slider_horizontal_3,
                      size: 16,
                      color: CupertinoColors.activeBlue,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Mostrando: $selectedFilter',
                      style: TextStyle(
                        color: CupertinoColors.activeBlue,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

            SizedBox(height: 16),

            // Lista de tareas
            Expanded(
              child: filtered.isEmpty
                  ? _buildEmptyState()
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) => SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final tarea = filtered[index];
                        final isOverdue =
                            tarea['fecha'].isBefore(DateTime.now()) && !tarea['completada'];

                        return Container(
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemBackground,
                            borderRadius: BorderRadius.circular(12),
                            border: isOverdue
                                ? Border.all(
                                    color: CupertinoColors.systemRed.withOpacity(0.3),
                                    width: 1,
                                  )
                                : null,
                          ),
                          child: CupertinoListTile(
                            leading: GestureDetector(
                              onTap: () => _toggleTaskCompletion(index),
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: tarea['completada']
                                        ? CupertinoColors.systemGreen
                                        : CupertinoColors.systemGrey3,
                                    width: 2,
                                  ),
                                  color: tarea['completada']
                                      ? CupertinoColors.systemGreen
                                      : CupertinoColors.systemBackground,
                                ),
                                child: tarea['completada']
                                    ? Icon(
                                        CupertinoIcons.checkmark,
                                        size: 14,
                                        color: CupertinoColors.white,
                                      )
                                    : null,
                              ),
                            ),
                            title: Text(
                              tarea['titulo'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                decoration: tarea['completada']
                                    ? TextDecoration.lineThrough
                                    : null,
                                color: tarea['completada']
                                    ? CupertinoColors.secondaryLabel
                                    : CupertinoColors.label,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (tarea['descripcion'] != null &&
                                    tarea['descripcion'].isNotEmpty)
                                  Text(
                                    tarea['descripcion'],
                                    style: TextStyle(
                                      color: CupertinoColors.secondaryLabel,
                                      fontSize: 14,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.calendar,
                                      size: 12,
                                      color: isOverdue
                                          ? CupertinoColors.systemRed
                                          : CupertinoColors.secondaryLabel,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      '${tarea['fecha'].day}/${tarea['fecha'].month}/${tarea['fecha'].year}',
                                      style: TextStyle(
                                        color: isOverdue
                                            ? CupertinoColors.systemRed
                                            : CupertinoColors.secondaryLabel,
                                        fontSize: 12,
                                        fontWeight:
                                            isOverdue ? FontWeight.w600 : FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _getPriorityColor(tarea['prioridad'])
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        tarea['prioridad'],
                                        style: TextStyle(
                                          color: _getPriorityColor(tarea['prioridad']),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Icon(
                              CupertinoIcons.chevron_right,
                              color: CupertinoColors.secondaryLabel,
                              size: 16,
                            ),
                            onTap: () => _showTaskDetails(tarea),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: CupertinoColors.secondaryLabel,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.tray,
            size: 64,
            color: CupertinoColors.systemGrey3,
          ),
          SizedBox(height: 16),
          Text(
            'No hay tareas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: CupertinoColors.secondaryLabel,
            ),
          ),
          SizedBox(height: 8),
          Text(
            selectedFilter == 'Todas'
                ? 'Crea tu primera tarea desde el menú'
                : 'No hay tareas ${selectedFilter.toLowerCase()}',
            style: TextStyle(
              fontSize: 16,
              color: CupertinoColors.secondaryLabel,
            ),
            textAlign: TextAlign.center,
          ),
        ],
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
}

// Widget auxiliar mejorado para simular ListTile en Cupertino
class CupertinoListTile extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const CupertinoListTile({
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              SizedBox(width: 16),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                  if (subtitle != null) ...[
                    SizedBox(height: 4),
                    subtitle!,
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[
              SizedBox(width: 16),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}

// REGISTRO TAREA MEJORADO
class RegistroTareaScreen extends StatefulWidget {
  @override
  State<RegistroTareaScreen> createState() => _RegistroTareaScreenState();
}

class _RegistroTareaScreenState extends State<RegistroTareaScreen> {
  final TextEditingController tareaController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
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
  if (tareaController.text.isEmpty) {
      _showAlert('Error', 'Por favor ingresa el título de la tarea');
      return;
    }

  setState(() => _isLoading = true);

  // Simular proceso de registro
  await Future.delayed(Duration(seconds: 1));

  setState(() => _isLoading = false);

  _showAlert('Éxito', 'Usuario registrado correctamente', onOk: () async {
    // Espera a que el diálogo se cierre antes de hacer pop a la pantalla
    await Future.delayed(Duration(milliseconds: 200));
    Navigator.pop(context); // Regresar al menú principal
  });
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
            Navigator.pop(context); // Cierra el diálogo
            if (onOk != null) onOk();
          },
        ),
      ],
    ),
  );
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
                  children: [
                    CupertinoTextField(
                      controller: tareaController,
                      placeholder: 'Título de la tarea',
                      padding: EdgeInsets.all(16),
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
                    CupertinoTextField(
                      controller: descripcionController,
                      placeholder: 'Descripción (opcional)',
                      maxLines: 3,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(),
                      prefix: Padding(
                        padding: EdgeInsets.only(left: 16, top: 16),
                        child: Icon(
                          CupertinoIcons.doc_text,
                          color: CupertinoColors.secondaryLabel,
                        ),
                      ),
                    ),
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
}