import 'package:flutter/material.dart';
import 'package:pong_simple/widgets/pong.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({Key? key}) : super(key: key);

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen>
    with TickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    // lowerBound: 0,
    // upperBound: 100,
    duration: const Duration(milliseconds: 800),
  );
  late Animation<double> animation = Tween(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(parent: controller, curve: Curves.decelerate));

  @override
  void initState() {
    controller.addListener(() {
      setState(() {});
    });

    controller.repeat(reverse: true);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final bounceHeight = constraints.maxHeight * 0.5;
          final ballSize = constraints.maxWidth * 0.2;
          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: ballSize,
                    height: bounceHeight,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: animation.value * (bounceHeight - ballSize),
                          child: Container(
                            height: ballSize,
                            width: ballSize,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.indigo,
                                  Colors.red,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Simple Pong',
                    style: TextStyle(
                      color: Colors.indigo[200],
                      fontWeight: FontWeight.w800,
                      fontSize: 35,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Pong()));
        },
        child: const Text("Start"),
        backgroundColor: Colors.pink[300],
      ),
    );
  }
}
