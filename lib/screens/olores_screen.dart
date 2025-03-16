import 'package:flutter/material.dart';
import 'package:sabores_anonimos/model/olores.dart';
import '../database/database.dart';
import '../widgets/olor_widget.dart';

class OloresScreen extends StatefulWidget {
  @override
  _OloresScreenState createState() => _OloresScreenState();
}

class _OloresScreenState extends State<OloresScreen> {
  late Future<List<Olores>> _futureOlores;
  int? seleccionadoId; // Guarda el ID del seleccionado

  @override
  void initState() {
    super.initState();
    _cargarOlores();
  }

  void _cargarOlores() {
    setState(() {
      _futureOlores = DatabaseHelper.obtenerOlores();
    });
  }

  void _seleccionarSabor(Olores olorSeleccionado) async {
    setState(() {
      seleccionadoId = olorSeleccionado.id;
    });

    // Actualizar la base de datos
    await DatabaseHelper.actualizarEstadoOlor(olorSeleccionado.id);


    // Volver a cargar los sabores actualizados
    _cargarOlores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Olores")),
      body: FutureBuilder<List<Olores>>(
        future: _futureOlores,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No hay olores disponibles"));
          }

          return ListView(
            children: snapshot.data!.map((olor) {
              return OlorWidget(
                olor: olor,
                onSeleccionado: _seleccionarSabor,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
