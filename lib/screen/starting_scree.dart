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
    lowerBound: 0,
    upperBound: 100,
    duration: const Duration(milliseconds: 800),
  );
  late Animation<double> animation =
      Tween(begin: 50.0, end: 300.0).animate(controller);

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
      body: Center(
        child: Stack(
          children: [
            Positioned(
              left: 100.0,
              top: controller.value,
              child: Container(
                height: 200,
                width: 200,
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
            Positioned(
              top: 350.0,
              left: 90,
              child: Text(
                '  Simple Pong',
                style: TextStyle(
                    color: Colors.indigo[200],
                    fontWeight: FontWeight.w800,
                    fontSize: 35),
              ),
            ),
          ],
        ),
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
