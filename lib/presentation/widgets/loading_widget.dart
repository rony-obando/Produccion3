import 'package:flutter/material.dart';

class LoadingImage extends StatelessWidget {
  final String imageUrl;

  const LoadingImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Image.asset(
          imageUrl,
          width: 250, 
          height: 250,
        ),
       
      ],
    ),
    color: Colors.white,
    );
  }
}
