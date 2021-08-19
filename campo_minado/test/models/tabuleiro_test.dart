import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('Ganhar jogo', () {
    Tabuleiro tabuleiro = Tabuleiro(
      linhas: 2,
      colunas: 2,
      qtdeBombas: 0,
    );

    tabuleiro.campos[0].minar();
    tabuleiro.campos[3].minar();

    // Jogando...
    tabuleiro.campos[0].alternarMarcacao();
    print(tabuleiro.campos[0].marcado);
    tabuleiro.campos[1].abrir();
    print(tabuleiro.campos[1].marcado);
    tabuleiro.campos[2].abrir();
    print(tabuleiro.campos[2].marcado);
    tabuleiro.campos[3].alternarMarcacao();
    print(tabuleiro.campos[3].marcado);

    expect(tabuleiro.resolvido, isTrue);
  });
}
