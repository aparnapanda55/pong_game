import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pong_simple/screen/starting_scree.dart';
import 'package:pong_simple/widgets/ball.dart';
import 'package:pong_simple/widgets/bat.dart';
import 'package:google_fonts/google_fonts.dart';

enum Direction {
  up,
  down,
  left,
  right,
}

//Pong class
class Pong extends StatefulWidget {
  const Pong({Key? key}) : super(key: key);

  @override
  _PongState createState() => _PongState();
}

//PongState class
class _PongState extends State<Pong> with SingleTickerProviderStateMixin {
  //
  //Animation variable assigned to values....
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 50),
  );
  late Animation<double> animation =
      Tween(begin: 0.0, end: 250.0).animate(controller);
  //...........------..........

  //variables to declare position.....
  late double width = 0;
  late double height = 0;
  double posX = 0;
  double posY = 0;
  double batWidth = 0;
  double batHeight = 0;
  double batPosition = 0;
  //......--------...........

  //Direction variable aassigned to enum down and right....
  Direction vertiDir = Direction.down;
  Direction horiDir = Direction.right;
  //......--------...........

  //Random number positions
  double randX = 1;
  double randY = 1;
  //......--------...........

  //Score
  int score = 0;

  //increment variable
  double increment = 5;

  //init class for increasing x and y position of ball...
  @override
  void initState() {
    animation.addListener(() {
      setState(() {
        horiDir == Direction.right ? posX += increment : posX -= increment;
        vertiDir == Direction.down ? posY += increment : posY -= increment;
      });
      checkBorders();
    });

    controller.forward();
    super.initState();
  }
  //......--------...........

  //Dispose class tp prevent memory leaks
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  //......--------...........

  //Function for changing the direction of BALL once hits the border...
  void checkBorders() {
    const diameter = 50;
    if (posX <= 0 && horiDir == Direction.left) {
      horiDir = Direction.right;
      randX = randomNumber();
    }
    if (posX >= width - diameter && horiDir == Direction.right) {
      horiDir = Direction.left;
      randX = randomNumber();
    }
    if (posY >= height - diameter - batHeight && vertiDir == Direction.down) {
      if (posX >= batPosition - diameter &&
          posX <= batPosition + batWidth + diameter) {
        vertiDir = Direction.up;
        randY = randomNumber();
        score++;
      } else {
        controller.stop();
        showScoreCard(context);
      }
    }
    if (posY <= 0 && vertiDir == Direction.up) {
      vertiDir = Direction.down;
      randY = randomNumber();
    }
  }
  //......--------...........

  //Function to move the bat in horizontal direction..
  void moveBat(DragUpdateDetails update) {
    setState(() {
      batPosition += update.delta.dx;
    });
  }
  //......--------...........

  //function to create random number
  double randomNumber() {
    var myNum = Random().nextInt(101);
    return (myNum + 50) / 100;
  }
  //......--------...........

  //Function to show Score Card...
  void showScoreCard(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Game Over'),
            content: const Text('Play again..'),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    posX = 0;
                    posY = 0;
                    score = 0;
                  });
                  Navigator.of(context).pop();
                  controller.repeat();
                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (cotext) => const StartingScreen(),
                    ),
                  );
                },
                child: const Text('No'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5C527F),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            height = constraints.maxHeight;
            width = constraints.maxWidth;
            batWidth = width / 5;
            batHeight = height / 20;
            return Stack(
              children: [
                Positioned(
                  top: posY,
                  left: posX,
                  child: const Ball(),
                ),
                Positioned(
                  bottom: 0,
                  left: batPosition,
                  child: GestureDetector(
                    child: Bat(
                      height: batHeight,
                      width: batWidth,
                    ),
                    onHorizontalDragUpdate: (DragUpdateDetails update) {
                      moveBat(update);
                    },
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Card(
                    elevation: 20,
                    color: Color(0xfffC996CC),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Score: ' + score.toString(),
                        style: GoogleFonts.robotoMono(
                          textStyle: const TextStyle(
                            color: Color(0xfff261C2C),
                            fontWeight: FontWeight.w900,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
