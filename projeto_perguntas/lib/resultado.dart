import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Resultado extends StatelessWidget {
  final int pontuacao;
  Resultado(this.pontuacao);

  String get fraseResultado {
    if (pontuacao < 8) {
      return 'Parabéns!';
    } else if (pontuacao < 12) {
      return 'Você é bom!';
    } else if (pontuacao < 16) {
      return 'Impressionante!';
    } else {
      return 'Legendary!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        fraseResultado,
        style: TextStyle(fontSize: 20),
      )
    );
  }
}
