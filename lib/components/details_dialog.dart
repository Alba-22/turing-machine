import 'package:flutter/material.dart';

import 'package:turing_machine/models/turing_machine.dart';

import '../models/transition_function.dart';

class MachineDetailsDialog extends StatelessWidget {
  final TuringMachine machine;

  const MachineDetailsDialog({
    Key? key,
    required this.machine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.75,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  machine.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  machine.description,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black45,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 2,
                  width: double.infinity,
                  color: Colors.purple,
                )
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _renderTupleItem("Alfabeto", "{${machine.alphabet.join(",")}}"),
                          _renderTupleItem("Símbolos da Fita", "{${machine.tapeSymbols.join(",")}}"),
                          _renderTupleItem("Estados", "{${machine.states.join(",")}}"),
                          _renderTupleItem("Estado Inicial", machine.initialState),
                          _renderTupleItem("Símbolo Branco", machine.blankState),
                          _renderTupleItem("Estados Finais", "{${machine.finalStates.join(",")}}"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Transições",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          ...machine.transitions.map((e) {
                            return Text(
                              _getTransition(e),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                fontWeight: FontWeight.w300,
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderTupleItem(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  String _getTransition(TransitionFunction transition) {
    return "∂(${transition.currentState}, ${transition.readSymbol}) = (${transition.nextState}, ${transition.writtenSymbol}, ${transition.movementDirection.name[0].toUpperCase()})";
  }
}
