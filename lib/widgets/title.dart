import 'package:flutter/cupertino.dart';

class MyTitle extends StatelessWidget {
  final String title;

  const MyTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: CupertinoColors.activeBlue),
          // center the text
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
