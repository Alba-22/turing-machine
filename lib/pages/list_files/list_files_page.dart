import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:turing_machine/models/turing_machine.dart';
import 'package:turing_machine/pages/enter_string/enter_string_page.dart';

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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EnterStringPage(
                                  selectedTuringMachine: machine,
                                ),
                              ),
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
