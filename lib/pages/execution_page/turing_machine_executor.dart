import 'package:flutter/material.dart';
import 'package:turing_machine/models/movement_direction.dart';

import 'package:turing_machine/models/turing_machine.dart';
import 'package:turing_machine/utils/extensions.dart';

class TuringMachineExecutor extends ChangeNotifier {
  final String input;
  final TuringMachine turingMachine;
  int headLocation = 0;

  late String currentState;
  late String tape;
  late Map<int, String> tapeView;

  TuringMachineExecutor({
    required this.input,
    required this.turingMachine,
  }) {
    tape = "$input${turingMachine.blankState}";
    tapeView = "$input${turingMachine.blankState}".split("").asMap();
    currentState = turingMachine.initialState;
  }

  void processTapeSymbol() {
    final String symbolBeingRead = tape[headLocation];
    final resultingTransition = turingMachine.transitions.where((element) {
      return element.readSymbol == symbolBeingRead && element.currentState == currentState;
    }).toList();
    if (resultingTransition.isEmpty) {
      print("Cadeia Rejeitada!");
      // REJEITA A CADEIA
      return;
    }
    currentState = resultingTransition.first.nextState;
    if (turingMachine.finalStates.contains(currentState)) {
      // ACEITA A CADEIA
      print("ACABO!");
      return;
    }
    tape = tape.replaceCharAt(headLocation, resultingTransition.first.writtenSymbol);
    if (resultingTransition.first.movementDirection == MovementDirection.right) {
      // TODO: Resolver caso de overflow de index quando for ler os símbolos brancos após a fita
      // if (headLocation++ > tape.length) {
      //   tape = "$tape${turingMachine.blankState}";
      // }
      headLocation++;
    } else {
      // TODO: Tratar pra caso chegar no início da fita(headLocation será -1)
      headLocation--;
    }
    notifyListeners();
  }
}
