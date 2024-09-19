import 'package:flutter/material.dart';

class InputCaption extends StatelessWidget {
  final String caption;
  final Widget child;
  const InputCaption({super.key, required this.caption, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              caption,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 42, 132, 45)),
            ),
            child
          ],
        ),
      ),
    );
  }
}
