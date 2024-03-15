import 'package:flutter/material.dart';

class ColorText extends StatefulWidget {
  final String text;
  const ColorText({super.key, required this.text});

  @override
  State<ColorText> createState() => _ColorTextState();
}

class _ColorTextState extends State<ColorText> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text,style:const TextStyle(color: Colors.orange));
  }
}