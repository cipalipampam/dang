import 'package:flutter/material.dart';

import '../../../constants.dart';

class SplashContent extends StatefulWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  State<SplashContent> createState() => _SplashContentState();
}

class _SplashContentState extends State<SplashContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(),
        const Text(
          "DangLing",
          style: TextStyle(
            fontSize: 32,
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          widget.text!,
          textAlign: TextAlign.center,
        ),
        const Spacer(flex: 2),
        // Memuat gambar jika ada, jika tidak tampilkan kontainer abu-abu
        if (widget.image != null && widget.image!.isNotEmpty)
          Image.asset(
            widget.image!,
            height: 265,
            width: 235,
          )
        else
          Container(
            height: 265,
            width: 235,
            color: Colors.grey, // Warna default sebagai placeholder
            child: const Center(child: Text("No Image Available")),
          ),
      ],
    );
  }
}
