import 'package:flutter/material.dart';

import 'componentes/jogo_da_velha.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  // Layout Superior
                  Container(
                    color: const Color.fromARGB(255, 182, 180, 47),
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Jogo Da Velha',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Meu Aplicativo
                  Expanded(
                    child: Center(
                      child: Container(
                        width: constraints.maxWidth * 1.0,
                        height: constraints.maxHeight * 0.8,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(183, 203, 188, 231),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: JogoDaVelha(),
                        ),
                      ),
                    ),
                  ),

                  // Layout Inferior
                  //Container(
                  // width: double.infinity,
                  //padding: const EdgeInsets.all(16),
                  //child: const Text(
                  //'Layout Inferior',
                  // textAlign: TextAlign.center,
                  // style: TextStyle(fontSize: 16),
                  // ),
                  //),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
