import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:turing_machine/models/turing_machine.dart';
import 'package:turing_machine/pages/enter_string/enter_string_page.dart';

class ListFilesPage extends StatefulWidget {
  const ListFilesPage({Key? key}) : super(key: key);

  @override
  State<ListFilesPage> createState() => _ListFilesPageState();
}

class _ListFilesPageState extends State<ListFilesPage> {
  Future<List<TuringMachine>> _loadTuringMachines() async {
    try {
      final result = await DefaultAssetBundle.of(context).loadString("assets/turing_machines.json");
      final List decodedMachines = jsonDecode(result);
      return decodedMachines.map((e) {
        return TuringMachine.fromMap(e);
      }).toList();
    } catch (e, stacktrace) {
      print(stacktrace);
      print(e);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Implementação da Máquina de Turing",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _loadTuringMachines(),
        builder: (context, AsyncSnapshot<List<TuringMachine>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data != null) {
            return ListView.separated(
              padding: const EdgeInsets.only(top: 20),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EnterStringPage(
                          selectedTuringMachine: snapshot.data![index],
                        ),
                      ),
                    );
                  },
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 10,
                      ),
                      height: MediaQuery.of(context).size.width * 0.02,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Align(
                              child: Text(
                                "MÁQUINA DE TURING ${index + 1}",
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 20);
              },
            );
          }

          return const Text("DEU RUIM");
        },
      ),
    );
  }
}
