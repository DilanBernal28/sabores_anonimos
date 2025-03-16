import 'package:flutter/material.dart';
import '../database/database.dart';
import '../model/sabores.dart';
import '../widgets/sabor_widget.dart';

class SaboresScreen extends StatefulWidget {
  @override
  _SaboresScreenState createState() => _SaboresScreenState();
}

class _SaboresScreenState extends State<SaboresScreen> {
  late Future<List<Sabor>> _futureSabores;
  int? seleccionadoId; // Guarda el ID del seleccionado

  @override
  void initState() {
    super.initState();
    _cargarSabores();
  }

  void _cargarSabores() {
    setState(() {
      _futureSabores = DatabaseHelper.obtenerSabores();
    });
  }

  void _seleccionarSabor(Sabor saborSeleccionado) async {
    setState(() {
      seleccionadoId = saborSeleccionado.id;
    });

    // Actualizar la base de datos
    await DatabaseHelper.actualizarEstadoSabor(saborSeleccionado.id);


    // Volver a cargar los sabores actualizados
    _cargarSabores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Sabores")),
      body: FutureBuilder<List<Sabor>>(
        future: _futureSabores,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No hay sabores disponibles"));
          }

          return ListView(
            children: snapshot.data!.map((sabor) {
              return SaborWidget(
                sabor: sabor,
                onSeleccionado: _seleccionarSabor,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
