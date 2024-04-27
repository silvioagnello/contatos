import 'package:flutter/material.dart';

class Mensagens {
  messageSnack(context, msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg.toString()),
      ),
    );
  }
}
