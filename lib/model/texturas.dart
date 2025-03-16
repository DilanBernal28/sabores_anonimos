import 'package:sabores_anonimos/model/estado.dart';

class Olor {
  final int id;
  final String name;
  Estado estado;

  Olor({required this.id, required this.name, required this.estado});

  factory Olor.fromJson(Map<String, dynamic> json) {
    return Olor(
      id: json['id'],
      name: json['name'],
      estado: Estado.values.firstWhere(
            (e) => e.toString() == 'Estado.${json['estado']}',
        orElse: () => Estado.desconocido,
      ),
    );
  }
}

