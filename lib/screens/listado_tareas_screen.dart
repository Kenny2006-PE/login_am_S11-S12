import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../widgets/cupertino_list_tile.dart';
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