import 'package:projeto_questionario/widgets/pontuacao_final.dart';
import 'package:projeto_questionario/widgets/questionario.dart';
import 'package:flutter/material.dart';

import 'data/perguntas.dart';

void main() {
  runApp(const PerguntaApp());
}

class PerguntaAppState extends State<PerguntaApp> {
  @override
  void initState() {
    super.initState();
    iniciaPerguntas();
  }

  var perguntaSelecionada = 0;
  var totalPontos = 0;
  Future<List<Pergunta>>? perguntasFuture;

  void iniciaPerguntas() {
    perguntasFuture = Pergunta.geraPerguntasAsync();
  }

  void responder(int? pontuacao) {
    setState(() {
      perguntaSelecionada++;
      totalPontos += pontuacao!;
    });
  }

  void resetarPontuacao() {
    setState(() {
      iniciaPerguntas();
      totalPontos = 0;
      perguntaSelecionada = 0;
    });
  }

  temMaisPerguntas(List<Pergunta> perguntas) {
    var length = perguntas.length;
    var paraRetornar = perguntaSelecionada < length;
    return paraRetornar;
  }

  maxPontuacao(List<Pergunta> perguntas) {
    var maioresValores = perguntas.map((pergunta) => pergunta.respostas!.reduce(
        (value, element) =>
            value.pontuacao! > element.pontuacao! ? value : element));

    return maioresValores.fold(
        0, (previousValue, element) => previousValue + element.pontuacao!);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Perguntas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: perguntasFuture,
          builder: (c, s) {
            if (s.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (s.hasError) {
              return const Text('Erro ao carregar perguntas');
            } else {
              List<Pergunta> perguntas = s.data!;

              return temMaisPerguntas(perguntas)
                  ? Questionario(
                      perguntaSelecionada: perguntaSelecionada,
                      perguntas: perguntas,
                      responder: responder)
                  : PontuacaoFinal(
                      totalPontos: totalPontos,
                      maxPontuacao: maxPontuacao(perguntas),
                      resetarPontuacao: resetarPontuacao);
            }
          },
        ),
      ),
    ));
  }
}

class PerguntaApp extends StatefulWidget {
  const PerguntaApp({Key? key}) : super(key: key);

  @override
  State<PerguntaApp> createState() {
    return PerguntaAppState();
  }
}
