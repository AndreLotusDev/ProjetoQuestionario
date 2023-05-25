import 'package:projeto_questionario/data/perguntas.dart';
import 'package:flutter/material.dart';

class Questionario extends StatelessWidget {
  final int perguntaSelecionada;
  final List<Pergunta> perguntas;
  final void Function(int?) responder;

  const Questionario(
      {super.key,
      required this.perguntaSelecionada,
      required this.perguntas,
      required this.responder});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: double.infinity,
        child: Text(perguntas[perguntaSelecionada].texto!),
        alignment: Alignment.center,
      ),
      ...(perguntas[perguntaSelecionada].respostas!).map((resposta) {
        return TextButton(
          child: Text(resposta.texto!),
          onPressed: () => responder(resposta.pontuacao),
        );
      }).toList()
    ]);
  }
}
