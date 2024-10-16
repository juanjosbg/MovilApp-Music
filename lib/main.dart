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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribuye espacio entre título y botón
          children: [
            Text(widget.title), // Título en la izquierda
            IconButton(
              icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode), // Ícono de alternar tema
              onPressed: () {
                widget.toggleTheme(); // Alternar el tema cuando se presiona el botón
              },
            ),
          ],
        ),
        backgroundColor: const Color(0xFFFEA500), // Color #FEA en hexadecimal
        elevation: 4, // Añadir sombra en la parte inferior del AppBar
        shadowColor: Colors.black.withOpacity(0.5), // Sombra negra con opacidad del 50%
      ),
      body: Center(
        child: Text('Contenido de la aplicación aquí'),
      ),
    );
  }
}
