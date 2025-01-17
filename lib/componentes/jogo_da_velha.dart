// Suggested code may be subject to a license. Learn more: ~LicenseLog:2712799591.

import 'dart:math';

import 'package:flutter/material.dart';

class JogoDaVelha extends StatefulWidget {
  const JogoDaVelha({super.key});

  @override
  State<JogoDaVelha> createState() => _JogoDaVelhaState();
}

class _JogoDaVelhaState extends State<JogoDaVelha> {
  // ignore: unused_field
  List<String> _tabuleiro = List.filled(9, '');
  String _jogador = 'X';
  bool _contraMaquina = false; 
  final Random randomico = Random();
  //String _mensagem = '';

  void _iniciarJogo() {
    setState(() {
      _tabuleiro = List.filled(9, '');
      _jogador = 'X';
      // _mensagem = '';
    });
  }

  void _trocaJogador() {
    setState(() {
      _jogador = _jogador == 'X' ? 'O' : 'X';
    });
  }

  // ignore: non_constant_identifier_names
  void _mostraDialogoVencedor(String Vencedor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Vencedor == 'Empate' ? 'Empate!' : 'Vencedor: $Vencedor'),
          actions: [
            ElevatedButton(
              child: const Text('Reiniciar Jogo'),
              onPressed: () {
                Navigator.of(context).pop();
                _iniciarJogo();
              },
            ),
          ],
        );
      },
    );
  }

  bool _verificaVencedor(String jogador) {
    const List<List<int>> posicoesVencedoras = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var posicoes in posicoesVencedoras) {
      if (_tabuleiro[posicoes[0]] == jogador &&
          _tabuleiro[posicoes[1]] == jogador &&
          _tabuleiro[posicoes[2]] == jogador) {
        _mostraDialogoVencedor(jogador);
        return true;
      }
    }
    if (!_tabuleiro.contains('')) {
      _mostraDialogoVencedor('Empate');
      return true;
    }
    return false;
  }

  void _jogadaComputador() {
    Future.delayed(const Duration(seconds: 1), () {
      int movimento;
      do {
        movimento = randomico.nextInt(9);
      } while (_tabuleiro[movimento] != '');

      setState(() {
        _tabuleiro[movimento] = 'O';
        if (!_verificaVencedor(_jogador)) {
          _trocaJogador();
        }
      });
    });
  }

  void _jogada(int index) {
    if (_tabuleiro[index] == '') {
      setState(() {
        _tabuleiro[index] = _jogador;
        if (!_verificaVencedor(_jogador)) {
          _trocaJogador();
          if (_contraMaquina && _jogador == 'O') {
            _jogadaComputador();
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height * 0.5;
    return Column(
      children: [
        Row(
          children: [
            Transform.scale(
              scale: 0.6,
              child: Switch(
                value: _contraMaquina,
                onChanged: (value) {
                  setState(() {
                    _contraMaquina = value;
                    _iniciarJogo();
                  });
                },
              ),
            ),
            Text(_contraMaquina ? 'Computador' : 'Humano')
          ],
        ),
        SizedBox(
          width: altura,
          height: altura,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 colunas na grade
              crossAxisSpacing: 5.0, // Espaçamento entre as colunas
              mainAxisSpacing: 5.0, // Espaçamento entre as linhas
            ),
            itemCount: 9, // Número total de itens na grade
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _jogada(index),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 29, 224, 110), // Cor de fundo azul claro
                    borderRadius:
                        BorderRadius.circular(5), // Bordas arredondadas
                  ),
                  child: Center(
                    child: Text(
                      _tabuleiro[index],
                      // ignore: prefer_const_constructors
                      style: const TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: _iniciarJogo,
          child: const Text('Reiniciar Jogo'),
        ),
      ],
    );
  }
}
