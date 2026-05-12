import 'package:flutter/material.dart';

class AvatarUnknownWidget extends StatelessWidget {
  const AvatarUnknownWidget({
    super.key,
    this.height = 55,
    this.width = 55,
  });
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height,
          width: width,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(70),
              child: Image.asset(
                'assets/images/avatar_default.jpg',
                fit: BoxFit.cover,
              )),
        ),
      ],
    );
  }
}
