import 'package:flutter/cupertino.dart';

class FlagObject {
  final String name;
  final String countryCode;

  FlagObject({required this.name, required this.countryCode});

  String get getFlagImage => "assets/flags/${countryCode.toLowerCase()}.jpg";
}

class FlagImage extends StatelessWidget {
  final String flagImage;

  const FlagImage({super.key, required this.flagImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: CupertinoColors.black,
            width: 2,
          ),
        ),
        child: Image.asset(
          flagImage,
          width: 300,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class FlagText extends StatefulWidget {
  final FlagObject flagObject;
  final VoidCallback flagCallback;
  // calback that returns the name of the flag

  const FlagText({
    super.key,
    required this.flagObject,
    required this.flagCallback,
  });

  @override
  State<FlagText> createState() => _FlagTextState();
}

class _FlagTextState extends State<FlagText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: widget.flagCallback,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  widget.flagObject.name,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.black),
                  // center the text
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
