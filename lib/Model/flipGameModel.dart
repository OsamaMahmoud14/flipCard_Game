import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';

enum Level { VeryEasy,Hard, Medium, Easy,VeryHard }

List<String> fillSourceArray() {
  return [
    'assets/animals/a1.png',
    'assets/animals/a1.png',
    'assets/animals/a2.png',
    'assets/animals/a2.png',
    'assets/animals/a3.png',
    'assets/animals/a3.png',
    'assets/animals/a4.png',
    'assets/animals/a4.png',
    'assets/animals/a5.png',
    'assets/animals/a5.png',
    'assets/animals/a6.png',
    'assets/animals/a6.png',
    'assets/animals/dino.png',
    'assets/animals/dino.png',
    'assets/animals/wolf.png',
    'assets/animals/wolf.png',
    'assets/animals/peacock.png',
    'assets/animals/peacock.png',
    'assets/animals/whale.png',
    'assets/animals/whale.png',
    'assets/animals/octo.png',
    'assets/animals/octo.png',
    'assets/animals/fish.png',
    'assets/animals/fish.png',
    'assets/animals/frog.png',
    'assets/animals/frog.png',
    'assets/animals/seahorse.png',
    'assets/animals/seahorse.png',
    'assets/animals/girraf.png',
    'assets/animals/girraf.png',

  ];
}

List ? getSourceArray(
    Level  level
    ) {
  List<String> levelAndKindList = [];
  List sourceArray = fillSourceArray();
  if (level == Level.VeryHard) {
    for (int i = 0; i < 16; i++) {
      levelAndKindList.add(sourceArray[i]);
    }

  }
  if (level == Level.VeryEasy) {
    for (int i = 0; i < 4; i++) {
      levelAndKindList.add(sourceArray[i]);
    }

  }
  else if (level == Level.Hard) {
    for (int i = 0; i < 14; i++) {
      levelAndKindList.add(sourceArray[i]);
    }
  }  else if (level == Level.Medium) {
    for (int i = 0; i < 10; i++) {
      levelAndKindList.add(sourceArray[i]);
    }
  } else if (level == Level.Easy) {
    for (int i = 0; i < 6; i++) {
      levelAndKindList.add(sourceArray[i]);
    }
  }

  levelAndKindList.shuffle();
  return levelAndKindList;
}
//4 6 10 14 16
List<bool> getInitialItemState(Level ? level) {
  List<bool> initialItemState = [];
  if (level == Level.Hard) {
    for (int i = 0; i < 14; i++) {
      initialItemState.add(true);
    }
  } else if (level == Level.Medium) {
    for (int i = 0; i < 10; i++) {
      initialItemState.add(true);
    }
  } else if (level == Level.Easy) {
    for (int i = 0; i < 6; i++) {
      initialItemState.add(true);
    }
  }
  else if (level == Level.VeryEasy) {
    for (int i = 0; i < 4; i++) {
      initialItemState.add(true);
    }
  }
  else if (level == Level.VeryHard) {
    for (int i = 0; i < 16; i++) {
      initialItemState.add(true);
    }
  }
  return initialItemState;
}

List<GlobalKey<FlipCardState>> getCardStateKeys(Level ? level) {
  List<GlobalKey<FlipCardState>> cardStateKeys =
  [];
  if (level == Level.VeryHard) {
    for (int i = 0; i < 16; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  } else if (level == Level.Medium) {
    for (int i = 0; i < 10; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  } else if (level == Level.Easy) {
    for (int i = 0; i < 6; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  }
  else if (level == Level.VeryEasy) {
    for (int i = 0; i < 4; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  }
  else if (level == Level.Hard) {
    for (int i = 0; i < 14; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  }
  return cardStateKeys;
}
