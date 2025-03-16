import 'package:flutter/material.dart';
import '../database/database.dart';
import '../model/texturas.dart';
import '../widgets/textura_widget.dart';

class TexturasScreen extends StatefulWidget {
  @override
  _TexturasScreenState createState() => _TexturasScreenState();
}

class _TexturasScreenState extends State<TexturasScreen> {
  late Future<List<Olor>> _futureTexturas;
  int? seleccionadoId; // Guarda el ID del seleccionado

  @override
  void initState() {
    super.initState();
    _cargarTexturas();
  }

  void _cargarTexturas() {
    setState(() {
      _futureTexturas = DatabaseHelper.obtenerTexturas();
    });
  }

  void _seleccionaTextura(Olor texturaSeleccionada) async {
    setState(() {
      seleccionadoId = texturaSeleccionada.id;
    });

    await DatabaseHelper.actualizarEstadoTextura(texturaSeleccionada.id);


    // Volver a cargar las texturas actualizadas
    _cargarTexturas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Texturas")),
      body: FutureBuilder<List<Olor>>(
        future: _futureTexturas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No hay texturas disponibles"));
          }

          return ListView(
            children: snapshot.data!.map((textura) {
              return TexturaWidget(
                textura: textura,
                onSeleccionado: _seleccionaTextura,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
