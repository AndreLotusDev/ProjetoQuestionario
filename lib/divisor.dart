import 'package:flutter/material.dart';

class Divisor extends StatelessWidget {
  const Divisor({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Colors.grey,
      thickness: 1.0,
      height: 20.0,
      indent: 20.0,
      endIndent: 20.0,
    );
  }
}
