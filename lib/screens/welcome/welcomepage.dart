import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomePage extends StatelessWidget {
  final String? topText1;
  final String? topText2;
  final String? svgImagePath;
  final String? subtitle;
  const WelcomePage(
      {Key? key,
      this.topText1,
      this.topText2,
      this.svgImagePath,
      this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 100,
          ),
          Text(
            topText1 ?? 'TopText1',
            style: TextStyle(
              fontFamily: 'SplineSans',
              fontSize: 24,
              color: Colors.deepPurple[900],
            ),
          ),
          Text(
            topText2 ?? 'TopText2',
            style: TextStyle(
              fontFamily: 'SplineSans',
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple[900],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 200,
            child: SvgPicture.asset(
              svgImagePath ?? 'assets/svgs/Welcome-01.svg',
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: Text(
              subtitle ?? 'Subtitle.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'SplineSans',
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.purple[900],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
