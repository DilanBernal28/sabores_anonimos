import 'package:flutter/material.dart';
import 'package:sabores_anonimos/model/texturas.dart';
import '../model/estado.dart';

class TexturaWidget extends StatefulWidget {
  final Olor textura;
  final Function(Olor) onSeleccionado;

  const TexturaWidget({Key? key, required this.textura, required this.onSeleccionado}) : super(key: key);

  @override
  _TexturaWidgetState createState() => _TexturaWidgetState();
}

class _TexturaWidgetState extends State<TexturaWidget> {
  void _seleccionar() {
    if (widget.textura.estado == Estado.no) {
      setState(() {
        widget.textura.estado = Estado.si;
      });

      widget.onSeleccionado(widget.textura);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: widget.textura.estado == Estado.si ? Colors.grey[400] : Colors.white,
      child: ListTile(
        title: Text(widget.textura.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text("Estado: ${widget.textura.estado.name}", style: TextStyle(color: Colors.grey[600])),
        leading: Icon(Icons.apps_rounded, color: Colors.blueAccent),
        trailing: widget.textura.estado == Estado.si
            ? Icon(Icons.check, color: Colors.blue)
            : ElevatedButton(
          onPressed: _seleccionar,
          child: Text("Seleccionar"),
        ),
      ),
    );
  }
}
