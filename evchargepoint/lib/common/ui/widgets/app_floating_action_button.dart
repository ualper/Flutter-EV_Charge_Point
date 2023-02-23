import 'package:flutter/material.dart';

import '../../routes.dart';

class AppFloatingActionButton extends StatelessWidget {
  const AppFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.greenAccent.withOpacity(0.5),
            spreadRadius: 0.5,
            blurRadius: 2,
            offset: const Offset(0, -2), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(3),
      height: 68,
      width: 68,
      child: FittedBox(
        child: FloatingActionButton(
          elevation: 0,
          shape: const CircleBorder(),
          backgroundColor: Colors.white,
          child: const Icon(Icons.electric_bolt_rounded, color: Colors.teal),
          onPressed: () {
            Navigator.of(context).pushNamed(chargingScreenRoute);
          },
        ),
      ),
    );
  }
}
