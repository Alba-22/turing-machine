import 'package:flutter/material.dart';
import 'package:turing_machine/components/details_dialog.dart';

import 'package:turing_machine/models/turing_machine.dart';

class ExecutionHeader extends StatelessWidget {
  final TuringMachine machine;

  const ExecutionHeader({
    Key? key,
    required this.machine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.chevron_left_rounded,
              color: Colors.purple,
              size: 40,
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              machine.name,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              machine.description,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return MachineDetailsDialog(machine: machine);
                            },
                          );
                        },
                        child: const Text(
                          "Detalhes da Máquina",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 2,
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: Colors.purple,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
