import 'package:flutter/material.dart';

class LogoAndFormText extends StatelessWidget {
  const LogoAndFormText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/form_logo.png',
          fit: BoxFit.fitWidth,
          height: 50,
          width: 210,
        ),
        const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Car Rental Request Form',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )),
      ],
    );
  }
}