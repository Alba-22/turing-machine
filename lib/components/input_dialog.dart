import 'package:flutter/material.dart';

import 'package:turing_machine/models/turing_machine.dart';

class InputDialog extends StatefulWidget {
  final Function(String) onNext;
  final TuringMachine machine;

  const InputDialog({Key? key, required this.onNext, required this.machine}) : super(key: key);

  @override
  State<InputDialog> createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  final inputController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.25,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Digite a cadeia desejada abaixo:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Alfabeto válido: {${widget.machine.alphabet.join(",")}}",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black45,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                child: TextFormField(
                  controller: inputController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value != null) {
                      final chars = value.split("").toList();
                      for (final char in chars) {
                        if (!widget.machine.alphabet.contains(char)) {
                          return "Cadeia contém símbolos inválidos";
                        }
                      }
                      if (value.isEmpty) {
                        return null;
                      }
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    Navigator.pop(context);
                    widget.onNext(inputController.text);
                    inputController.clear();
                  }
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width, 50),
                  ),
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                child: const Text(
                  "Processar Cadeia",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
