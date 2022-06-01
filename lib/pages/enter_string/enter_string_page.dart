import 'package:flutter/material.dart';

import 'package:turing_machine/models/turing_machine.dart';
import 'package:turing_machine/pages/execution_page/execution_page.dart';

class EnterStringPage extends StatefulWidget {
  final TuringMachine selectedTuringMachine;

  const EnterStringPage({
    Key? key,
    required this.selectedTuringMachine,
  }) : super(key: key);

  @override
  State<EnterStringPage> createState() => _EnterStringPageState();
}

class _EnterStringPageState extends State<EnterStringPage> {
  final input = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 200,
              child: TextField(
                controller: input,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExecutionPage(
                      input: input.text,
                      turingMachine: widget.selectedTuringMachine,
                    ),
                  ),
                );
              },
              child: const Text(
                "PROCESSAR CADEIA",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
