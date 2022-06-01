import 'package:flutter/material.dart';

import 'package:turing_machine/models/turing_machine.dart';
import 'turing_machine_executor.dart';

class ExecutionPage extends StatefulWidget {
  final String input;
  final TuringMachine turingMachine;

  const ExecutionPage({
    Key? key,
    required this.input,
    required this.turingMachine,
  }) : super(key: key);

  @override
  State<ExecutionPage> createState() => _ExecutionPageState();
}

class _ExecutionPageState extends State<ExecutionPage> {
  late TuringMachineExecutor executor;

  @override
  void initState() {
    super.initState();
    executor = TuringMachineExecutor(
      input: widget.input,
      turingMachine: widget.turingMachine,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "EXECUÇÃO DA CADEIA ${widget.input}",
        ),
      ),
      body: AnimatedBuilder(
        animation: executor,
        builder: (context, child) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: executor.tape.split("").map((e) {
                    return Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          e,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Text(
                  "Símbolo sendo lido: ${executor.tape[executor.headLocation]}",
                ),
                Text(
                  "Estado atual: ${executor.currentState}",
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    executor.processTapeSymbol();
                  },
                  child: const Text(
                    "AVANÇAR",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
