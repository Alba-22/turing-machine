import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const AutoSizeText(
          "IMPLEMENTAÇÃO DA MÁQUINA DE TURING",
          maxLines: 1,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 2,
          width: MediaQuery.of(context).size.width * 0.5,
          color: Colors.purple,
        )
      ],
    );
  }
}
