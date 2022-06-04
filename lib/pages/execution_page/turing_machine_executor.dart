import 'dart:async';

import 'package:flutter/material.dart';
import 'package:turing_machine/models/movement_direction.dart';
import 'package:turing_machine/models/transition_function.dart';

import 'package:turing_machine/models/turing_machine.dart';

enum ExecutionState {
  paused,
  accept,
  reject,
  running,
}

class TuringMachineExecutor extends ChangeNotifier {
  final String input;
  final TuringMachine turingMachine;
  int headLocation = 0;

  late String currentState;
  Map<int, String> tape = {};

  Timer? timer;
  late ExecutionState executionState;
  late String executionMessage;

  double sliderValue = 0.5;

  TuringMachineExecutor({
    required this.input,
    required this.turingMachine,
  }) {
    initTuringMachine();
  }

  void initTuringMachine() {
    tape = input.split("").asMap();
    tape = Map.fromEntries(tape.entries);
    currentState = turingMachine.initialState;
    headLocation = 0;
    executionState = ExecutionState.paused;
    executionMessage = "Máquina Não Iniciada";
    timer?.cancel();
    notifyListeners();
  }

  int _getMillisecondsValue(double sliderValue) {
    if (sliderValue == 1) return 10;
    if (sliderValue == 0) return 1000;

    final milliseconds = 2 * (1 - sliderValue) * 500;
    return milliseconds.round();
  }

  void handlePlayPause() {
    if (executionState == ExecutionState.paused) {
      executionState = ExecutionState.running;
      executionMessage = "Máquina Executando";
      timer = Timer.periodic(Duration(milliseconds: _getMillisecondsValue(sliderValue)), (_) {
        processTapeSymbol();
      });
    } else if (executionState == ExecutionState.running) {
      executionState = ExecutionState.paused;
      executionMessage = "Máquina Pausada";
      timer?.cancel();
    }
    notifyListeners();
  }

  void changeSpeed(double value) {
    sliderValue = value;
    if (executionState == ExecutionState.running) {
      timer?.cancel();
      timer = Timer.periodic(Duration(milliseconds: _getMillisecondsValue(sliderValue)), (_) {
        processTapeSymbol();
      });
    }
    notifyListeners();
  }

  void processTapeSymbol() {
    executionState = ExecutionState.running;
    executionMessage = "Máquina Executando";
    notifyListeners();

    //Posição atual na Fita
    final String symbolBeingRead = tape[headLocation].toString();

    //Achando a lista de transições que casam com o símbolo lido e
    //com o estado atual, representando a tupla ∂(q0,a)
    final resultingTransition = turingMachine.transitions.where((element) {
      return element.readSymbol == symbolBeingRead && element.currentState == currentState;
    }).toList();

    //Caso a lista de transições for vazia, rejeite a cadeia
    if (resultingTransition.isEmpty) {
      _rejectInput();
      return;
    }

    _reWriteSymbols(resultingTransition);

    //Caso, o proximo estado for o estado final, aceite a cadeia
    currentState = resultingTransition.first.nextState;
    if (turingMachine.finalStates.contains(currentState)) {
      _acceptInput();
      return;
    }
    notifyListeners();
  }

  ///Reescreva o atual símbolo lido com o símbolo a ser escrito
  _reWriteSymbols(List<TransitionFunction> resultingTransition) {
    tape[headLocation] = resultingTransition.first.writtenSymbol;
    if (resultingTransition.first.movementDirection == MovementDirection.right) {
      if (headLocation + 1 >= tape.length) {
        tape[headLocation + 1] = turingMachine.blankState;
      }
      headLocation++;
    } else {
      if (headLocation - 1 < 0) {
        _rejectInput();
      } else {
        headLocation--;
      }
    }
  }

  void _acceptInput() {
    executionState = ExecutionState.accept;
    executionMessage = "Máquina ACEITA a Cadeia $input";
    timer?.cancel();
    notifyListeners();
  }

  void _rejectInput() {
    executionState = ExecutionState.reject;
    executionMessage = "Máquina REJEITA a Cadeia $input";
    timer?.cancel();
    notifyListeners();
  }
}
