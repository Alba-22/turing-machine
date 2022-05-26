import 'dart:convert';

import 'transition_function.dart';

class TuringMachine {
  final List<String> states;
  final List<String> alphabet;
  final List<String> tapeSymbols;
  final List<TransitionFunction> transitions;
  final String initialState;
  final String blankState;
  final List<String> finalStates;

  TuringMachine({
    required this.states,
    required this.alphabet,
    required this.tapeSymbols,
    required this.transitions,
    required this.initialState,
    required this.blankState,
    required this.finalStates,
  });

  Map<String, dynamic> toMap() {
    return {
      'states': states,
      'alphabet': alphabet,
      'tapeSymbols': tapeSymbols,
      'transitions': transitions.map((x) => x.toMap()).toList(),
      'initialState': initialState,
      'blankState': blankState,
      'finalStates': finalStates,
    };
  }

  factory TuringMachine.fromMap(Map<String, dynamic> map) {
    return TuringMachine(
      states: List<String>.from(map['states']),
      alphabet: List<String>.from(map['alphabet']),
      tapeSymbols: List<String>.from(map['tapeSymbols']),
      transitions: List<TransitionFunction>.from(map['transitions']?.map((x) => TransitionFunction.fromMap(x))),
      initialState: map['initialState'] ?? '',
      blankState: map['blankState'] ?? '',
      finalStates: List<String>.from(map['finalStates']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TuringMachine.fromJson(String source) => TuringMachine.fromMap(json.decode(source));
}
