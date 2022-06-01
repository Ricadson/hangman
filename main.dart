// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

List<dynamic> word = [
  {"name": "bonjou", "desc": "Mo ki pou salye moun"},
  {"name": "ayiti", "desc": "Se non peyi kote nou ap viv la"},
  {"name": "kreyol", "desc": "se yon lang"}
];
int chans = 5;
var rang = Random();

int randomIndex = rang.nextInt(word.length); // 0 --->

var chosenWord = word[randomIndex];
String hiddenChar = "";
var keywords = [
  'q',
  'w',
  'e',
  'r',
  't',
  'y',
  'u',
  'o',
  'p',
  'i',
  'a',
  's',
  'd',
  'f',
  'g',
  'h',
  'j',
  'k',
  'l',
  'z',
  'x',
  'c',
  'v',
  'b',
  'n',
  'm'
];
Cachee() {
  if (hiddenChar.isEmpty && hiddenChar.length < chosenWord['name'].length) {
    for (var i = 0; i < chosenWord['name'].length; i++) {
      hiddenChar += "*";
    }
  }
  return hiddenChar;
}

void main() {
  runApp(Hangman());
}

class Hangman extends StatelessWidget {
  const Hangman({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroPage(),
      debugShowCheckedModeBanner: false,
      title: "Hangman App",
    );
  }
}

class IntroPage extends StatefulWidget {
  IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hangman'),
          elevation: 2,
          actions: [
            Row(
              children: [
                Text(
                  chans.toString(),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.star,
                      color: Colors.amber,
                    )),
              ],
            ),
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                color: Colors.blue,
                padding: EdgeInsets.all(10),
                child: Text(
                  "Hangman",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              ListTile(
                title: Text('Rejwe'),
              ),
              ListTile(
                title: Text('Ed'),
              ),
              ListTile(
                title: Text('Kite'),
                onTap: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              hiddenChar.toString(),
              style: TextStyle(fontSize: 50.0),
            ),
            Text(chosenWord['desc'].toString(),
                style: TextStyle(fontSize: 25.0)),
            SizedBox(
              height: 200,
            ),
            Container(
              height: 300,
              width: 1000,
              child: Wrap(

                  // ignore: prefer_const_literals_to_create_immutables
                  children: keywords
                      .map(
                        (letter) => Wrap(children: [
                          ElevatedButton(
                              child: Text(letter),
                              onPressed: () {
                                setState(() {
                                  Cha(letter);
                                  verifie(chosenWord['name'].toString(),
                                      hiddenChar);
                                });
                              })
                        ]),
                      )
                      .toList()),
            ),
          ]),
        ));
  }
}

Cha(String letter) async {
  if (chosenWord['name'].contains(letter)) {
    print("Yes");

    List indexes = [];
    for (var i = 0; i < chosenWord['name'].length; i++) {
      if (chosenWord['name'][i] == letter) {
        indexes.add(i);
      }
    }
  } else {
    chans -= 1;
  }
}

verifie(String chosenword, String hiddenChar) {
  if (chosenWord == hiddenChar) {
    print("li egal");
  } else {
    print("li pa egal");
  }
}
