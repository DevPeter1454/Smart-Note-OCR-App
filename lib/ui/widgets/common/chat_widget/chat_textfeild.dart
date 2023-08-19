// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomTextField extends StatelessWidget {
  final Function() onPressed;
  final TextEditingController txt;
  const BottomTextField({Key? key, required this.onPressed, required this.txt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Container(
        margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Theme.of(context).cardColor,
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: TextField(
                  controller: txt,
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: 'Type something...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: onPressed,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 24.0,
                ),
                child: Icon(
                  Icons.send,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
