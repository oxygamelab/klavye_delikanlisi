import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyAppHome(),
    );
  }
}

class MyAppHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppHomeState();
  }
}

class _MyAppHomeState extends State<MyAppHome> {
  int step = 0;
  int score = 0;
  String lorem =
      "                         Lorem ipsum dolor sit amet, consectetur adipiscing elites. Aliquam nec diam quis erat tincidunt consectetur a in tortor. Cras varius arcu at consectetur mollis. Aenean nisl nibh, ultricies a enim sit amet, euismod efficitur ex. Phasellus porttitor nibh augue, nec vestibulum quam cursus a. Sed condimentum a lacus vitae facilisis. Quisque sed mauris dignissim, vulputate dui a, dignissim erat. Proin tempus convallis dapibus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse ut augue lorem. Mauris malesuada neque tellus, fermentum commodo libero tempor in. Cras molestie, diam sed faucibus imperdiet, mauris felis aliquet urna, a ornare nisl eros et libero. Quisque interdum ex sit amet est tempor malesuada. Aenean placerat in justo vitae pellentesque. Praesent vel tincidunt sem, id ullamcorper sapien. Suspendisse blandit posuere luctus. Pellentesque quis porttitor dolor."
          .toLowerCase()
          .replaceAll('.', '')
          .replaceAll(',', '');

  void onStartGame() {
    setState(() {
      score = 0;
      step = 1;
    });
  }

  void onChangeMyText(String mytext) {
    print(mytext);
    if (lorem.trimLeft().indexOf(mytext) == 0) {
      setState(() {
        score = mytext.length;
      });
    } else {
      // game over
      setState(() {
        step = 2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var showWidget;

    if (step == 0) {
      showWidget = <Widget>[
        Text('Başlamaya hazırmısın ?'),
        Padding(
          padding: const EdgeInsets.only(top: 32),
          child: RaisedButton(
            onPressed: onStartGame,
            child: Text('Oyuna Başla', style: TextStyle(fontSize: 20)),
          ),
        ),
      ];
    } else if (step == 1) {
      showWidget = <Widget>[
        Text(score.toString()),
        Container(
          height: 30,
          child: Marquee(
            text: lorem,
            style: TextStyle(fontSize: 24, letterSpacing: 2),
            scrollAxis: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            blankSpace: 20.0,
            velocity: 50.0,
            pauseAfterRound: Duration(seconds: 1),
            startPadding: 0,
            accelerationDuration: Duration(seconds: 1),
            accelerationCurve: Curves.linear,
            decelerationDuration: Duration(milliseconds: 500),
            decelerationCurve: Curves.easeOut,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
          child: TextField(
            onChanged: onChangeMyText,
            autofocus: true,
            autocorrect: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Yaz bakalım',
            ),
          ),
        ),
      ];
    } else if (step == 2) {
      showWidget = <Widget>[
        Text('Skorun: $score'),
        Padding(
          padding: const EdgeInsets.only(top: 32),
          child: RaisedButton(
            onPressed: onStartGame,
            child: Text('Tekrar Başla', style: TextStyle(fontSize: 20)),
          ),
        ),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Klavye Delikanlısı'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: showWidget,
        ),
      ),
    );
  }
}
