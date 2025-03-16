import 'package:sabores_anonimos/model/estado.dart';

class Sabor {
  final int id;
  final String name;
  Estado estado;

  Sabor({required this.id, required this.name, required this.estado});

  factory Sabor.fromJson(Map<String, dynamic> json) {
    return Sabor(
      id: json['id'],
      name: json['name'],
      estado: Estado.values.firstWhere(
            (e) => e.toString() == 'Estado.${json['estado']}',
        orElse: () => Estado.desconocido,
      ),
    );
  }
}