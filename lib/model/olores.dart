import 'package:sabores_anonimos/model/estado.dart';

class Olores {
  final int id;
  final String name;
  Estado estado;

  Olores({required this.id, required this.name, required this.estado});

  factory Olores.fromJson(Map<String, dynamic> json) {
    return Olores(
      id: json['id'],
      name: json['name'],
      estado: Estado.values.firstWhere(
            (e) => e.toString() == 'Estado.${json['estado']}',
        orElse: () => Estado.desconocido,
      ),
    );
  }
}

