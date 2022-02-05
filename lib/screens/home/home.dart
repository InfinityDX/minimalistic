import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:minimalmusic/components/bottombar.dart';
import 'package:minimalmusic/components/topbar.dart';
import 'package:minimalmusic/screens/home/contents/album.dart';
import 'package:minimalmusic/screens/home/contents/playlist.dart';
import 'package:minimalmusic/screens/home/contents/tracks.dart';
import 'package:minimalmusic/screens/home/player.dart';
import 'package:minimalmusic/services/appanimation.dart';
import 'package:minimalmusic/services/appstatus.dart';
import 'package:minimalmusic/services/audioservice.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late final tabController = TabController(length: 3, vsync: this);

  void toggleTopBarAnimation(double scrollOffset, AppAnimation appAnimation) {
    if (scrollOffset > 1.5) {
      appAnimation.showTopBar();
    }
    if (scrollOffset < -1.5) {
      appAnimation.hideTopBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarIconBrightness: Theme.of(context).brightness,
      ),
    );

    var _appAnimation = Provider.of<AppAnimation>(context);

    return WillPopScope(
      onWillPop: () async {
        if (_appAnimation.isBigPlayer) {
          _appAnimation.shrinkPlayer();
          return false;
        } else {
          return true;
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          statusBarIconBrightness:
              Theme.of(context).brightness == Brightness.dark
                  ? Brightness.light
                  : Brightness.dark,
        ),
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overScroll) {
                    overScroll.disallowGlow();
                    return true;
                  },
                  child: NotificationListener<ScrollUpdateNotification>(
                    onNotification: (scrollUpdateNotification) {
                      double scrollOffset =
                          scrollUpdateNotification.dragDetails == null
                              ? 0
                              : scrollUpdateNotification.dragDetails!.delta.dy;
                      toggleTopBarAnimation(scrollOffset, _appAnimation);
                      return true;
                    },
                    child: TabBarView(
                      controller: tabController,
                      children: const [
                        Tracks(),
                        Album(),
                        Playlist(),
                      ],
                    ),
                  ),
                ),

                // Top Bar
                const Align(alignment: Alignment.topRight, child: TopBar()),

                // Bottom Bar
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BottomBar(
                    tabController: tabController,
                  ),
                ),
                const Player()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
