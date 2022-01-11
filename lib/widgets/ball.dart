import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  const Ball({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const diam = 50.0;
    return Container(
      width: diam,
      height: diam,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xfffC996CC),
            Color(0xfff6E85B2),
          ],
        ),
      ),
    );
  }
}
