import 'package:flutter/material.dart';

class ListFilesPage extends StatefulWidget {
  const ListFilesPage({Key? key}) : super(key: key);

  @override
  State<ListFilesPage> createState() => _ListFilesPageState();
}

class _ListFilesPageState extends State<ListFilesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B1B),
      appBar: AppBar(
        title: const Text(
          "Implementação da Máquina de Turing",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
