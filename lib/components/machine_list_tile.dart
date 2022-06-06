import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:turing_machine/models/turing_machine.dart';

class MachineListTile extends StatelessWidget {
  final VoidCallback onTap;
  final TuringMachine machine;

  const MachineListTile({
    Key? key,
    required this.onTap,
    required this.machine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 80,
          width: MediaQuery.of(context).size.width * 0.5,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: 10,
                spreadRadius: 0,
                color: Colors.black.withOpacity(0.25),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      machine.name,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    AutoSizeText(
                      machine.description,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.black45,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.purple,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
