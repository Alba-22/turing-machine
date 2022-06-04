import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:turing_machine/components/input_dialog.dart';
import 'package:turing_machine/components/invalid_machine_dialog.dart';
import 'package:turing_machine/models/turing_machine.dart';
import 'package:turing_machine/pages/execution_page/execution_page.dart';

import '../../components/home_header.dart';
import '../../components/machine_list_tile.dart';

class ListFilesPage extends StatefulWidget {
  const ListFilesPage({Key? key}) : super(key: key);

  @override
  State<ListFilesPage> createState() => _ListFilesPageState();
}

class _ListFilesPageState extends State<ListFilesPage> {
  Future<List<TuringMachine>> _loadTuringMachines() async {
    try {
      final result = await DefaultAssetBundle.of(context).loadString("assets/jsons/turing_machines.json");
      final List decodedMachines = jsonDecode(result);
      return decodedMachines.map((e) {
        return TuringMachine.fromMap(e);
      }).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(height: 100),
            const HomeHeader(),
            Expanded(
              child: FutureBuilder(
                future: _loadTuringMachines(),
                builder: (context, AsyncSnapshot<List<TuringMachine>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return ListView.separated(
                      padding: const EdgeInsets.only(top: 40),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final TuringMachine machine = snapshot.data![index];
                        return MachineListTile(
                          machine: machine,
                          onTap: () {
                            final isMachineInvalid = _isMachineInvalid(machine);
                            if (isMachineInvalid) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return InvalidMachineDialog(
                                    machine: machine,
                                    onTap: () {
                                      _showInputDialog(context, machine);
                                    },
                                  );
                                },
                              );
                            } else {
                              _showInputDialog(context, machine);
                            }
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 20);
                      },
                    );
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/error.svg",
                        height: 300,
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        "Ocorreu um erro ao listar\nas Máquinas de Turing",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showInputDialog(BuildContext context, TuringMachine machine) {
    showDialog(
      context: context,
      builder: (context) {
        return InputDialog(
          machine: machine,
          onNext: (String input) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExecutionPage(
                  turingMachine: machine,
                  input: input,
                ),
              ),
            );
          },
        );
      },
    );
  }

  bool _isMachineInvalid(TuringMachine machine) {
    //Tem algum estado final que não faz parte da lista de estados ?
    for (final finalState in machine.finalStates) {
      if (!machine.states.contains(finalState)) {
        return true;
      }
    }

    //O estado inicial não faz parte da lista de estados ?
    for (final state in machine.states) {
      if (!machine.states.contains(state)) {
        return true;
      }
    }

    for (final transition in machine.transitions) {
      //O estado atual não está na lista de transicoes?
      if (!machine.states.contains(transition.currentState)) return true;

      //O próximo estado não está na lista de transicoes?
      if (!machine.states.contains(transition.nextState)) return true;

      //Tem algum simbolo lido da lista de transicoes que não faz parte do alfabeto dos simbolos que podem ser lidos ?
      if (!machine.alphabet.contains(transition.readSymbol) &&
          !machine.tapeSymbols.contains(transition.readSymbol) &&
          transition.readSymbol != machine.blankState) return true;

      //Tem algum simbolo para ser escrito da lista de transicoes que não faz parte do alfabeto dos simbolos que podem ser escritos ?
      if (!machine.tapeSymbols.contains(transition.writtenSymbol) &&
          !machine.alphabet.contains(transition.writtenSymbol) &&
          transition.readSymbol != machine.blankState) return true;
    }

    return false;
  }
}
