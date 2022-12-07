import 'package:flutter/material.dart';

class CircleNotification extends StatelessWidget {
  const CircleNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      IconButton(
          onPressed: () => {},
          icon: const Icon(
            Icons.circle,
            size: 25.0,
            color: Colors.red,
          )),
      const Positioned.fill(
        bottom: 0,
        right: 18,
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "2",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15
            ),
          ),
        ),
      )
    ]);
  }
}
