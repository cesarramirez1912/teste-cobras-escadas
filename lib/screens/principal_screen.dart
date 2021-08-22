import 'package:flutter/material.dart';
import 'dart:math';

import 'package:snake_app/models/CobrasEscadas.dart';
import 'package:snake_app/models/Image.dart';

class PrincipalScreen extends StatefulWidget {
  @override
  _PrincipalScreenState createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  CobrasEscadas _cobrasEscadas = new CobrasEscadas();

  ImageClass _escada1 = new ImageClass(
      posicaoInicial: 8, posicaoFinal: 58, urlImage: "images/ladder-1.png");
  ImageClass _escada2 = new ImageClass(
      posicaoInicial: 26, posicaoFinal: 74, urlImage: "images/ladder-2.png");
  ImageClass _escada3 = new ImageClass(
      posicaoInicial: 42, posicaoFinal: 93, urlImage: "images/ladder-3.png");
  ImageClass _cobra1 = new ImageClass(
      posicaoInicial: 56,
      posicaoFinal: 86,
      isSnacke: true,
      urlImage: "images/snacke-1.png");
  ImageClass _cobra2 = new ImageClass(
      posicaoInicial: 14,
      posicaoFinal: 33,
      isSnacke: true,
      urlImage: "images/snacke-2.png");
  ImageClass _cobra3 = new ImageClass(
      posicaoInicial: 49,
      posicaoFinal: 99,
      isSnacke: true,
      urlImage: "images/snacke-3.png");

  List<ImageClass> _listaImagensClass = [];

  void initState() {
    _listaImagensClass = [
      _escada1,
      _escada2,
      _escada3,
      _cobra1,
      _cobra2,
      _cobra3
    ];
    super.initState();
  }

  List<MaterialColor> colors = [
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange
  ];
  Random random = new Random();

  int posicaoA = -1;
  int posicaoB = -1;

  int diceOne = 1;
  int diceTwo = 1;

  bool turnA = true;
  bool initialState = true;

  bool gameOver = false;

  List<String> _diceOneImages = [
    "images/dice1.png",
    "images/dice2.png",
    "images/dice3.png",
    "images/dice4.png",
    "images/dice5.png",
    "images/dice6.png",
  ];

  String message = '';
  String messageSnacke = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text(
          "Cobras e escadas",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
                child: Stack(
              children: [
                GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 10,
                  children: List.generate(
                    100,
                    (index) {
                      return Container(
                          decoration: BoxDecoration(
                              color: colors[random.nextInt(4)].shade200,
                              border: Border.all(
                                color: Colors.black,
                              )),
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              (99 - index) == posicaoA
                                  ? _playerDot(
                                      Colors.red,
                                      index,
                                      posicaoA == posicaoB
                                          ? Alignment.topLeft
                                          : Alignment.center)
                                  : SizedBox(),
                              (99 - index) == posicaoB
                                  ? _playerDot(
                                      Colors.lightBlue,
                                      index,
                                      posicaoB == posicaoA
                                          ? Alignment.bottomRight
                                          : Alignment.center)
                                  : SizedBox(),
                              Container(
                                child: Center(
                                  child: Text(
                                    ((99 - index) + 1).toString(),
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ],
                          ));
                    },
                  ),
                ),
                Positioned(
                  top: 44,
                  left: 53,
                  child: Image.asset(
                    _escada1.urlImage,
                    gaplessPlayback: true,
                    width: 100,
                  ),
                ),
                Positioned(
                  top: 105,
                  left: 178,
                  child: RotationTransition(
                    turns: new AlwaysStoppedAnimation(188 / 360),
                    child: Image.asset(
                      _escada2.urlImage,
                      gaplessPlayback: true,
                      width: 100,
                    ),
                  ),
                ),
                Positioned(
                  top: 35,
                  right: 33,
                  child: RotationTransition(
                    turns: new AlwaysStoppedAnimation(186 / 360),
                    child: Image.asset(
                      _escada3.urlImage,
                      gaplessPlayback: true,
                      width: 97,
                    ),
                  ),
                ),
                Positioned(
                  right: 173,
                  top: 60,
                  child: RotationTransition(
                    turns: new AlwaysStoppedAnimation(12 / 360),
                    child: Image.asset(
                      _cobra1.urlImage,
                      gaplessPlayback: true,
                      width: 75,
                    ),
                  ),
                ),
                Positioned(
                  top: 260,
                  right: 39,
                  child: RotationTransition(
                    turns: new AlwaysStoppedAnimation(10 / 360),
                    child: Image.asset(
                      _cobra2.urlImage,
                      gaplessPlayback: true,
                    ),
                  ),
                ),
                Positioned(
                  top: 28,
                  left: 45,
                  child: RotationTransition(
                    turns: new AlwaysStoppedAnimation(355 / 360),
                    child: Image.asset(
                      _cobra3.urlImage,
                      gaplessPlayback: true,
                    ),
                  ),
                ),
              ],
            )),
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(bottom: 10),
              color: messageSnacke != ""
                  ? Colors.amberAccent.shade100
                  : Colors.white,
              child: Text(messageSnacke),
            ),
            Text(
              turnA ? "Vez do jogador 1" : "Vez do jogador 2",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            SizedBox(
              height: 5,
            ),
            Text(message),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text("- Jogador 1")
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text("- Jogador 2")
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              height: 100,
              child: Center(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    child: Image.asset(
                      _diceOneImages[diceOne - 1],
                      gaplessPlayback: true,
                      width: 60,
                      height: 60,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    child: Image.asset(
                      _diceOneImages[diceTwo - 1],
                      gaplessPlayback: true,
                      width: 60,
                      height: 60,
                    ),
                  ),
                ],
              )),
            ),
            Text("Dados: ${diceOne + diceTwo}"),
            gameOver
                ? ElevatedButton(
                    onPressed: (){
                      posicaoB=-1;
                      posicaoA=-1;
                      message="";
                      turnA=true;
                      gameOver=false;
                      setState(() {

                      });
                    },
                    child: Text("Reiniciar jogo!"),
                    style: ElevatedButton.styleFrom(
                      primary:Colors.orange ,
                    ),
                  )
                : ElevatedButton(
                    onPressed: () async {
                      int total = await sort();
                      updateDices(total);
                    },
                    child: Text("Jogar"),
                    style: ElevatedButton.styleFrom(
                      primary: turnA
                          ? Colors.red
                          : Colors.blue, // This is what you need!
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<int> sort() async {
    for (int i = 0; i < 6; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      diceOne = Random().nextInt(5) + 1;
      diceTwo = Random().nextInt(5) + 1;
      setState(() {});
    }

    int dado1 = diceOne;
    int dado2 = diceTwo;
    return _cobrasEscadas.jogar(dado1, dado2);
  }

  void updateDices(int somaDados) async {
    int aux = turnA ? posicaoA : posicaoB;

    if (aux + somaDados == 99) {
      for (int i = 0; i <= somaDados; i++) {
        await Future.delayed(const Duration(milliseconds: 600));
        if (turnA) {
          posicaoA = aux + i;
        } else {
          posicaoB = aux + i;
        }
        setState(() {});
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Booaa!"),
            content: Text(turnA
                ? "O jogador 1 é o vencedor!"
                : "O jogador 2 é o vencedor!"),
            actions: [
              TextButton(
                child: Text("Entendi"),
                onPressed: () {
                  Navigator.of(context)
                      .pop(); // dismisses only the dialog and returns nothing
                },
              ),
            ],
          );
        },
      );
      gameOver = true;
      message = turnA ? "O jogador 1 é o vencedor!" : "O jogador 2 é o vencedor!";
    } else {
      if (aux + somaDados > 99) {
        int auxPercorrerPositivo = 99 - aux;
        int auxPercorrerNegativo = somaDados - auxPercorrerPositivo;
        for (int i = 0; i <= auxPercorrerPositivo; i++) {
          await Future.delayed(const Duration(milliseconds: 600));
          if (turnA) {
            posicaoA = aux + i;
          } else {
            posicaoB = aux + i;
          }
          setState(() {});
        }
        int aux2 = turnA ? posicaoA - 1 : posicaoB - 1;
        for (int i = 0; i < auxPercorrerNegativo; i++) {
          await Future.delayed(const Duration(milliseconds: 600));
          if (turnA) {
            posicaoA = aux2 - i;
          } else {
            posicaoB = aux2 - i;
          }
          setState(() {});
        }
      } else {
        for (int i = 0; i <= somaDados; i++) {
          await Future.delayed(const Duration(milliseconds: 600));
          if (turnA) {
            posicaoA = aux + i;
          } else {
            posicaoB = aux + i;
          }
          setState(() {});
        }
      }

      var filterPosition = turnA ? posicaoA + 1 : posicaoB + 1;

      var res = _listaImagensClass.where((element) => element.isSnacke
          ? element.posicaoFinal == filterPosition
          : element.posicaoInicial == filterPosition);

      if (res.isNotEmpty) {
        await Future.delayed(const Duration(milliseconds: 600));
        bool eSnacke = res.first.isSnacke;
        if (turnA) {
          posicaoA = res.first.isSnacke
              ? res.first.posicaoInicial - 1
              : res.first.posicaoFinal - 1;
        } else {
          posicaoB = res.first.isSnacke
              ? res.first.posicaoInicial - 1
              : res.first.posicaoFinal - 1;
        }

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(eSnacke ? "Uuups!" : "Booaa!"),
              content: Text(eSnacke
                  ? "Na cabeca da cobra, foi pra baixo!"
                  : "Voce foi pra cima!"),
              actions: [
                TextButton(
                  child: Text("Entendi"),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // dismisses only the dialog and returns nothing
                  },
                ),
              ],
            );
          },
        );
      }
      if (turnA) {
        message = "O jogador 2 esta na casa ${posicaoB + 1}";
        turnA = false;
      } else {
        message = "O jogador 1 esta na casa ${posicaoA + 1}";
        turnA = true;
      }
    }
    setState(() {});
  }
}

Widget _playerDot(Color color, int index, Alignment alignment) {
  return Align(
    alignment: alignment,
    child: Container(
      width: 20.0,
      height: 20.0,
      decoration: new BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    ),
  );
}
