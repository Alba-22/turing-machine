import 'dart:convert';

import 'movement_direction.dart';

class TransitionFunction {
  final String currentState;
  final String readSymbol;
  final String nextState;
  final String writtenSymbol;
  final MovementDirection movementDirection;

  TransitionFunction({
    required this.currentState,
    required this.readSymbol,
    required this.nextState,
    required this.writtenSymbol,
    required this.movementDirection,
  });

  Map<String, dynamic> toMap() {
    return {
      'currentState': currentState,
      'readSymbol': readSymbol,
      'nextState': nextState,
      'writtenSymbol': writtenSymbol,
      'movementDirection': movementDirection.name,
    };
  }

  factory TransitionFunction.fromMap(Map<String, dynamic> map) {
    return TransitionFunction(
      currentState: map['currentState'] ?? '',
      readSymbol: map['readSymbol'] ?? '',
      nextState: map['nextState'] ?? '',
      writtenSymbol: map['writtenSymbol'] ?? '',
      movementDirection: MovementDirection.values.byName(map['movementDirection']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransitionFunction.fromJson(String source) => TransitionFunction.fromMap(json.decode(source));
}
