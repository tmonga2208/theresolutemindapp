import 'package:flutter/material.dart';
import 'package:theresolutemind/components/my_image.dart';

class UserTile extends StatelessWidget {
  final String text;
  final String UD;
  final void Function()? onTap;
  const UserTile(
      {super.key, required this.onTap, required this.text, required this.UD});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            ProfileImageWidget(userId: UD, radius: 20),
            const SizedBox(width: 10),
            Text(text)
          ],
        ),
      ),
    );
  }
}
