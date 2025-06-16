import 'package:flutter/material.dart';

class CustomTextBodyAuth extends StatelessWidget {
  final String bodyText;

  const CustomTextBodyAuth({super.key, required this.bodyText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        bodyText,
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}
