import 'package:flutter/material.dart';

Widget buildRichText(String text) {
  List<TextSpan> textSpans = [];

  // Split the response by '**'
  List<String> parts = text.split('**');

  // Loop through the parts and add TextSpans accordingly
  for (int i = 0; i < parts.length; i++) {
    if (i % 2 == 0) {
      // Regular text
      textSpans.add(TextSpan(
          text: parts[i],
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'HappyMonkey',
          )));
    } else {
      // Bold text
      textSpans.add(TextSpan(
          text: parts[i],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 19,
            fontFamily: "HappyMonkey",
            height: 1.5,
          )));
    }
  }

  return RichText(
    text: TextSpan(
      children: textSpans,
    ),
  );
}
