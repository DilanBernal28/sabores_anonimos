import 'package:flutter/material.dart';
import '../model/estado.dart';
import '../model/sabores.dart';

class SaborWidget extends StatefulWidget {
  final Sabor sabor;
  final Function(Sabor) onSeleccionado;

  const SaborWidget({Key? key, required this.sabor, required this.onSeleccionado}) : super(key: key);

  @override
  _SaborWidgetState createState() => _SaborWidgetState();
}

class _SaborWidgetState extends State<SaborWidget> {
  void _seleccionar() {
    if (widget.sabor.estado == Estado.no) {
      setState(() {
        widget.sabor.estado = Estado.si;
      });

      widget.onSeleccionado(widget.sabor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: widget.sabor.estado == Estado.si ? Colors.grey[400] : Colors.white,
      child: ListTile(
        title: Text(widget.sabor.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text("Estado: ${widget.sabor.estado.name}", style: TextStyle(color: Colors.grey[600])),
        leading: Icon(Icons.fastfood, color: Colors.orange),
        trailing: widget.sabor.estado == Estado.si
            ? Icon(Icons.check, color: Colors.green)
            : ElevatedButton(
          onPressed: _seleccionar,
          child: Text("Seleccionar"),
        ),
      ),
    );
  }
}
