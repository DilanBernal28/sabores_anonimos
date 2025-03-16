import 'package:flutter/material.dart';
import 'package:sabores_anonimos/model/olores.dart';
import '../model/estado.dart';

class OlorWidget extends StatefulWidget {
  final Olores olor;
  final Function(Olores) onSeleccionado;

  const OlorWidget({Key? key, required this.olor, required this.onSeleccionado}) : super(key: key);

  @override
  _OlorWidgetState createState() => _OlorWidgetState();
}

class _OlorWidgetState extends State<OlorWidget> {
  void _seleccionar() {
    if (widget.olor.estado == Estado.no) {
      setState(() {
        widget.olor.estado = Estado.si;
      });

      widget.onSeleccionado(widget.olor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: widget.olor.estado == Estado.si ? Colors.grey[400] : Colors.white,
      child: ListTile(
        title: Text(widget.olor.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text("Estado: ${widget.olor.estado.name}", style: TextStyle(color: Colors.grey[600])),
        leading: Icon(Icons.accessibility_outlined, color: Colors.yellowAccent),
        trailing: widget.olor.estado == Estado.si
            ? Icon(Icons.check, color: Colors.blue)
            : ElevatedButton(
          onPressed: _seleccionar,
          child: Text("Seleccionar"),
        ),
      ),
    );
  }
}
