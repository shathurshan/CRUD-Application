import 'package:flutter/material.dart';

class AppBarNew extends StatelessWidget {
  final String sectionName;
  const AppBarNew({
    Key? key,
    required this.sectionName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.network(
          "https://cdn1.iconfinder.com/data/icons/social-black-buttons/512/telegram-512.png",
          height: 25  ,
        ),
        const SizedBox(
          width: 8,
        ),
        const Text(
          "New App",
          style: TextStyle(
            color: Colors.yellowAccent,
            fontSize: 20,
          ),
        ),
        Text(
          '$sectionName',
          style: const TextStyle(
            color: Colors.yellowAccent,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
