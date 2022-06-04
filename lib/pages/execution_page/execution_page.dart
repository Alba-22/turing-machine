import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

  @override
  void initState() {
    super.initState();
    _initTuringMachine();
  }

  void _initTuringMachine() {
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
            const SizedBox(height: 16),
            const Text(
              "Cadeia sendo lida:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
            ),
            Text(
              widget.input,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
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
                        SizedBox(
                          width: 49.0 * executor.tape.length,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: executor.tapeView.entries.map((e) {
                              if (e.key == executor.headLocation) {
                                return Stack(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/head.svg",
                                      height: 60,
                                      width: 50,
                                    ),
                                    Positioned(
                                      right: 0,
                                      left: 0,
                                      bottom: 36,
                                      child: Center(
                                        child: Text(
                                          executor.currentState,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return const SizedBox();
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: executor.tapeView.entries.map((e) {
                            return Container(
                              height: 49,
                              width: 49,
                              decoration: BoxDecoration(
                                border: BorderDirectional(
                                  bottom: const BorderSide(
                                    width: 1,
                                    color: Colors.black,
                                  ),
                                  top: const BorderSide(
                                    width: 1,
                                    color: Colors.black,
                                  ),
                                  start: const BorderSide(
                                    width: 1,
                                    color: Colors.black,
                                  ),
                                  end: BorderSide(
                                    width: e.key == executor.tape.length ? 1 : 0,
                                    color: Colors.black,
                                  ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: executor.initTuringMachine,
                              child: const Icon(
                                Icons.restore_rounded,
                                size: 40,
                                color: Colors.purple,
                              ),
                            ),
                            const SizedBox(width: 12),
                            InkWell(
                              onTap: executor.handlePlayPause,
                              borderRadius: BorderRadius.circular(60),
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: const BoxDecoration(
                                  color: Colors.purple,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  executor.executionState != ExecutionState.running ? Icons.play_arrow_rounded : Icons.pause_rounded,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            InkWell(
                              onTap: () {
                                executor.processTapeSymbol();
                                executor.handlePlayPause();
                              },
                              child: const Icon(
                                Icons.double_arrow_rounded,
                                size: 40,
                                color: Colors.purple,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Slider(
                            value: executor.sliderValue,
                            onChanged: executor.changeSpeed,
                            divisions: 8,
                            label: "${executor.sliderValue * 2}x",
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(executor.executionState.name),
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
