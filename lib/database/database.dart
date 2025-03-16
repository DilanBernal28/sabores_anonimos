import 'package:mysql1/mysql1.dart';
import 'package:sabores_anonimos/model/estado.dart';
import 'package:sabores_anonimos/model/olores.dart';
import 'package:sabores_anonimos/model/sabores.dart';
import 'package:sabores_anonimos/model/texturas.dart';

class DatabaseHelper {
  static MySqlConnection? _connection;

  static Future<MySqlConnection> conectar() async {

    print("hola");

    if (_connection != null) {
      return _connection!;
    }

    print("conectar");

    try {
      final settings = ConnectionSettings(
        host: 'db4free.net',
        port: 3306,
        user: 'adminroot123',
        password: '12345678',
        db: 'sabores_anonimo',
      );

      _connection = await MySqlConnection.connect(settings);
      print("Conexion correcta");
      return _connection!;
    } catch (e) {
      print(e);
      cerrarConexion();
      throw Exception("No se pudo conectar a la base de datos");
    }
  }

  // 🔹 Obtener TODOS los sabores
  static Future<List<Sabor>> obtenerSabores() async {
    final conn = await conectar();
    List<Sabor> listaSabores = [];

    try {
      var results = await conn.query('SELECT * FROM sabores');
      for (var row in results) {
        listaSabores.add(Sabor(
          id: row['id'],
          name: row['nombre'],
          estado: row['estado'] == 'si' ? Estado.si : Estado.no,
        ));
      }
    } catch (e) {
      throw Exception("No se pudo conectar a la");
    }

    return listaSabores;
  }


  static Future<List<Olor>> obtenerTexturas() async {
    final conn = await conectar();
    List<Olor> listaTexturas = [];

    try {
      var results = await conn.query('SELECT * FROM texturas');
      for (var row in results) {
        listaTexturas.add(Olor(
          id: row['id'],
          name: row['nombre'],
          estado: row['estado'] == 'si' ? Estado.si : Estado.no,
        ));
      }
    } catch (e) {
      throw Exception("No se pudo conectar");
    }

    return listaTexturas;
  }

  static Future<List<Olores>> obtenerOlores() async {
    final conn = await conectar();
    List<Olores> listaOlores = [];

    try {
      var results = await conn.query('SELECT * FROM olores');
      for (var row in results) {
        listaOlores.add(Olores(
          id: row['id'],
          name: row['nombre'],
          estado: row['estado'] == 'si' ? Estado.si : Estado.no,
        ));
      }

    } catch (e) {
      print(e);
      throw Exception("No se pudo conectar");
    }

    return listaOlores;

  }

  static Future<void> actualizarEstadoSabor(int idSeleccionado) async {
    final conn = await conectar();

    try {

      await conn.query(
        "UPDATE sabores SET estado = 'si' WHERE id = ?",
        [idSeleccionado],
      );
      print("Se pudo guardar");
    } catch (e) {
      print(e);
      throw Exception("Error al actualizar el sabor");
    }
  }

  static Future<void> actualizarEstadoTextura(int idSeleccionado) async {
    final conn = await conectar();

    try {

      await conn.query(
        "UPDATE texturas SET estado = 'si' WHERE id = ?",
        [idSeleccionado],
      );
      print("Se pudo guardar");
    } catch (e) {
      print(e);
      throw Exception("Error al actualizar la textura");
    }
  }


  static Future<void> actualizarEstadoOlor(int idSeleccionado) async {
    final conn = await conectar();

    try {

      await conn.query(
        "UPDATE olores SET estado = 'si' WHERE id = ?",
        [idSeleccionado],
      );
      print("Se pudo guardar");
    } catch (e) {
      print(e);
      throw Exception("Error al actualizar el sabor");
    }
  }


  // 🔹 Cerrar conexión
  static Future<void> cerrarConexion() async {

    print("adios");

    if (_connection != null) {
      await _connection!.close();
      _connection = null;
      print("Cerrada");
    }
  }
}
