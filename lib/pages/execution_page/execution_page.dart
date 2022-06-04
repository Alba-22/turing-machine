import 'dart:async';

import 'package:flutter/material.dart';

import 'package:turing_machine/models/turing_machine.dart';
import '../../components/execution_header.dart';
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

  bool isRunning = false;
  late final Timer _timer;

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
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(height: 20),
            ExecutionHeader(machine: widget.turingMachine),
            Expanded(
              child: AnimatedBuilder(
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
                          children: executor.tapeView.entries.map((e) {
                            return Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                color: e.key == executor.headLocation ? Colors.red : Colors.transparent,
                              ),
                              child: Center(
                                child: Text(
                                  executor.tape.split("").elementAt(e.key),
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
                            setState(() {
                              isRunning = !isRunning;
                            });
                            if (isRunning) {
                              _timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
                                executor.processTapeSymbol();
                              });
                            }
                          },
                          child: Text(
                            !isRunning ? "Iniciar" : "Parar",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
