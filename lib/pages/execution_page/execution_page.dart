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

  final ScrollController scrollController = ScrollController();

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
                          width: 50.0 * executor.tape.length,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: executor.tape.entries.map((e) {
                              if (e.key == executor.headLocation) {
                                return Stack(
                                  children: [
                                    Positioned(
                                      child: SvgPicture.asset(
                                        "assets/images/head.svg",
                                        width: 50,
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      left: 0,
                                      bottom: 40,
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
                        Container(
                          color: Colors.purple[100],
                          height: 64,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: executor.tape.entries.map((e) {
                              return Container(
                                height: 64,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: e.key.isEven ? Colors.purple[200] : Colors.purple[100],
                                ),
                                child: Center(
                                  child: Text(
                                    e.value,
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
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
                              onTap: (executor.executionState == ExecutionState.accept) || (executor.executionState == ExecutionState.reject)
                                  ? null
                                  : () {
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
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          executor.executionMessage,
                          style: _messageStyle(),
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

  TextStyle _messageStyle() {
    if (executor.executionState == ExecutionState.accept) {
      return const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green);
    } else if (executor.executionState == ExecutionState.reject) {
      return const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red);
    }
    return const TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black);
  }
}
