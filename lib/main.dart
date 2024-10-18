import 'package:flutter/material.dart';
import 'components/custom_search_bar.dart'; // Importa el archivo que creaste
import 'screens/anime_catalog_page.dart';

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
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: MyHomePage(
        title: 'TuneSphere',
        toggleTheme: _toggleTheme,
        isDarkMode: _isDarkMode,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.toggleTheme,
    required this.isDarkMode,
  });

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
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              widget.toggleTheme();
            },
          ),
        ],
        backgroundColor: const Color(0xFFFEA500),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            const CustomSearchBar(),
            const SizedBox(height: 16),
            Expanded(child: AnimeCatalogPage()), // Integrar la página de catálogo aquí
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.account_circle, size: 32),
          onPressed: () {
            print('Inicio de sesión');
          },
        ),
        const SizedBox(width: 8),
        _buildCustomButton('Anime'),
        const SizedBox(width: 8),
        _buildCustomButton('Peliculas'),
        const SizedBox(width: 8),
        _buildCustomButton('Musica'),
      ],
    );
  }

  Widget _buildCustomButton(String text) {
    return ElevatedButton(
      onPressed: () {
        print('$text button pressed');
      },
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFEA500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}