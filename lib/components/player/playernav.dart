import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:minimalmusic/services/appanimation.dart';
import 'package:provider/provider.dart';

class PlayerNav extends StatelessWidget {
  const PlayerNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appAnimation = Provider.of<AppAnimation>(context);

    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: TextButton(
              onPressed: () {},
              child: const Icon(
                Icons.more_vert,
                size: 28,
              ),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: TextButton(
              onPressed: appAnimation.shrinkPlayer,
              child: const Icon(
                Entypo.chevron_down,
                size: 28,
              ),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
