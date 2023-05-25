import 'package:flutter/material.dart';

import '../divisor.dart';

class PontuacaoFinal extends StatelessWidget {

  final int totalPontos;
  final int maxPontuacao;
  final void Function() resetarPontuacao;
  

  const PontuacaoFinal({
    super.key,
    required this.totalPontos,
    required this.maxPontuacao,
    required this.resetarPontuacao,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Column(children: [
            Text(
              "Você fez $totalPontos pontos!",
              style: const TextStyle(fontSize: 28),
            ),
            Text(
              "Máximo de pontos possiveis: ${maxPontuacao}",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.green,
              ),
            ),
            const Divisor(),
            TextButton(
              child: const Text("Reiniciar"),
              onPressed: resetarPontuacao,
            )
          ]),
        )
      ],
    );
  }
}
