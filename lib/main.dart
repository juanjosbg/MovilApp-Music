import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App!!',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light, // Alterna entre temas
      home: MyHomePage(title: 'TuneSphere', toggleTheme: _toggleTheme, isDarkMode: _isDarkMode),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.toggleTheme, required this.isDarkMode});

  final String title;
  final Function toggleTheme;
  final bool isDarkMode;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // Solo el título en el AppBar
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode), // Ícono de alternar tema
            onPressed: () {
              widget.toggleTheme(); // Alternar el tema cuando se presiona el botón
            },
          ),
        ],
        backgroundColor: const Color(0xFFFEA500), // Color #FEA en hexadecimal
        elevation: 4, // Añadir sombra en la parte inferior del AppBar
        shadowColor: Colors.black.withOpacity(0.5), // Sombra negra con opacidad del 50%
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icono de inicio de sesión
                IconButton(
                  icon: const Icon(Icons.account_circle, size: 32),
                  onPressed: () {
                    // Acción para iniciar sesión
                    print('Inicio de sesión');
                  },
                ),
                // Tres botones con borderRadius de 20px
                _buildCustomButton('Todo'),
                const SizedBox(width: 8),
                _buildCustomButton('Musica'),
                const SizedBox(width: 8),
                _buildCustomButton('Podcast'),
                const SizedBox(width: 16),
              ],
            ),
            // Barra de búsqueda
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
            const SizedBox(height: 16),
            // Resto del contenido del cuerpo
            const Center(
              child: Text('Contenido de la aplicación aquí'),
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir botones personalizados con borde redondeado
  Widget _buildCustomButton(String text) {
    return ElevatedButton(
      onPressed: () {
        // Acción del botón
      },
      child: Text(
        text,
        style: const TextStyle(color: Colors.white), // Texto blanco
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF10375C), // Color de fondo personalizado
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Borde redondeado de 20px
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Espaciado interno del botón
      ),
    );
  }
}
