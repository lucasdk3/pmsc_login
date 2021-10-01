import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.14,
        child: Image.asset(
          'assets/logo.png',
        ),
      ),
    );
  }
}
