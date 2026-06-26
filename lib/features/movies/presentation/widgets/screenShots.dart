import 'package:flutter/cupertino.dart';

class ScreenShots extends StatelessWidget{
  final String image;
  const ScreenShots({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.network(image, fit: BoxFit.cover,)),
    );
  }

}