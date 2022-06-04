import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:turing_machine/components/input_dialog.dart';
import 'package:turing_machine/models/turing_machine.dart';
import 'package:turing_machine/pages/execution_page/execution_page.dart';

import '../../components/home_header.dart';
import '../../components/machine_list_tile.dart';

// TODO: Validar se máquina de Turing está válida

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
}
