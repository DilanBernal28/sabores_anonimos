import 'package:flutter/material.dart';
import 'package:sabores_anonimos/database/database.dart';
import 'package:sabores_anonimos/screens/olores_screen.dart';
import 'package:sabores_anonimos/screens/sabores_screen.dart';
import 'package:sabores_anonimos/screens/texturas_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _paginaActual = 0;

  final List<Widget> _pantallas = [
    TexturasScreen(),
    SaboresScreen(),
    OloresScreen(),
  ];

  void conexion() async{
    await DatabaseHelper.conectar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(

              child: _pantallas[_paginaActual],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: conexion,
                child: Text("Conectar"),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _paginaActual, // Indica la página seleccionada
        onTap: (index) {
          setState(() {
            _paginaActual = index; // Cambia la pantalla según el botón tocado
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.texture),
            label: 'Texturas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Sabores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility_outlined), // Puedes cambiarlo por otro icono más adecuado
            label: 'Olores',
          ),
        ],
      ),
    );
  }
}
