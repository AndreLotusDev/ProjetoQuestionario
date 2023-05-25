import 'dart:convert';
import 'package:http/http.dart' as http;

class Pergunta {
  String? texto;
  List<Resposta>? respostas;

  Pergunta({this.texto, this.respostas});

  static Future<List<Pergunta>> geraPerguntasAsync() async {
    List<Pergunta> perguntas = [];

    final response =
        await http.get(Uri.parse('https://opentdb.com/api.php?amount=10'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'];

      for (var result in results) {
        List<Resposta> respostas = [];
        for (var i = 0; i < result['incorrect_answers'].length; i++) {
          respostas.add(Resposta(
            texto: result['incorrect_answers'][i],
            pontuacao: 0,
          ));
        }
        respostas.add(Resposta(
          texto: result['correct_answer'],
          pontuacao: 10,
        ));

        perguntas.add(Pergunta(
          texto: result['question'],
          respostas: respostas,
        ));
      }
    } else {
      throw Exception('Erro ao carregar perguntas da API');
    }

    return perguntas;
  }
}

class Resposta {
  String? texto;
  int? pontuacao;

  Resposta({this.texto, this.pontuacao});
}
