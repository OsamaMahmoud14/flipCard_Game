import 'package:flip_card/flip_card.dart';
import 'package:flipcard_game/won_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'Model/flipGameModel.dart';


class FlipCardGame extends StatefulWidget {
  Level level;

  FlipCardGame({required this.level});



  @override
  _FlipCardGameState createState() => _FlipCardGameState(level );

}

 class _FlipCardGameState extends State<FlipCardGame> {
    _FlipCardGameState(this.level);
   late List<GlobalKey<FlipCardState>> cardStateKeys;


  int previousIndex = -1;
  bool flip = false;
  bool start = false;
  // late Level _level;
  bool wait = false;
  late Level level;
  late Timer timer;
  int time = 5;
  late int left;
  late bool isFinished;
  late List<String>? data= getSourceArray(level)?.cast<String>();

  late List<bool> cardFlips;


  Widget getItem(int index) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 3,
              spreadRadius: 0.8,
              offset: Offset(2.0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(5)),
      margin: EdgeInsets.all(4.0),
      child: Image.asset(data![index]),
    );
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        time = time - 1;
      });
    });
  }

  void restart() {
    startTimer();
     data = getSourceArray(level)?.cast<String>();

    cardFlips = getInitialItemState(level);
    cardStateKeys = getCardStateKeys(level);
    time = 5;
    left = (data!.length ~/ 2);

    isFinished = false;
    Future.delayed(const Duration(seconds: 6), () {
      setState(() {
        start = true;
        timer.cancel();
      });
    });
  }

  @override
  void initState() {
    super.initState();

    restart();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isFinished
        ?WonScreen(duration: 12,)
        : Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: time > 0
                    ? Text(
                  '$time',
                  style: Theme.of(context).textTheme.headline3,
                )
                    : Text(
                  'Left:$left',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) => start
                      ? FlipCard(
                      key: cardStateKeys[index],
                      onFlip: () {
                        if (!flip) {
                          flip = true;
                          previousIndex = index;
                        } else {
                          flip = false;
                          if (previousIndex != index) {
                            if (data![previousIndex] !=
                                data![index]) {
                              wait = true;

                              Future.delayed(
                                  const Duration(milliseconds: 1500),
                                      () {
                                    cardStateKeys[previousIndex]
                                        .currentState
                                        ?.toggleCard();
                                    previousIndex = index;
                                    cardStateKeys[previousIndex]
                                        .currentState
                                        ?.toggleCard();

                                    Future.delayed(
                                        const Duration(milliseconds: 160),
                                            () {
                                          setState(() {
                                            wait = false;
                                          });
                                        });
                                  });
                            } else {
                              cardFlips[previousIndex] = false;
                              cardFlips[index] = false;
                              print(cardFlips);

                              setState(() {
                                left -= 1;
                              });
                              if (cardFlips
                                  .every((t) => t == false)) {
                                print("Won");
                                Future.delayed(
                                    const Duration(milliseconds: 160),
                                        () {
                                      setState(() {
                                        isFinished = true;
                                        start = false;
                                      });
                                    });
                              }
                            }
                          }
                        }
                        setState(() {});
                      },
                      flipOnTouch: wait ? false : cardFlips[index],
                      direction: FlipDirection.HORIZONTAL,
                      front: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black45,
                                blurRadius: 3,
                                spreadRadius: 0.8,
                                offset: Offset(2.0, 1),
                              )
                            ]),
                        margin: EdgeInsets.all(4.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/animals/quest.png",
                          ),
                        ),
                      ),
                      back: getItem(index))
                      : getItem(index),
                  itemCount: data!.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
