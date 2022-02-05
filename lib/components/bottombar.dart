import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:minimalmusic/services/appanimation.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({required this.tabController, Key? key}) : super(key: key);
  final TabController tabController;

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar>
    with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 350),
  );

  late final _moveTop = Tween<double>(
    begin: 0,
    end: -60,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ),
  )..addListener(() {
      setState(() {});
    });

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appAnimation = Provider.of<AppAnimation>(context);

    appAnimation.isPlayerOn
        ? _animationController.forward()
        : _animationController.reverse();

    return Transform.translate(
      offset: Offset(0, _moveTop.value),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(90, 0, 90, 10),
        child: Container(
            height: 50,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  offset: const Offset(2.5, 2.5),
                  blurRadius: 5,
                ),
              ],
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: TabBar(
              controller: widget.tabController,
              tabs: const [
                Tab(
                  icon: Icon(
                    MaterialIcons.audiotrack,
                    size: 32,
                  ),
                ),
                Tab(
                  icon: Icon(
                    MaterialCommunityIcons.album,
                    size: 32,
                  ),
                ),
                Tab(
                  icon: Icon(
                    MaterialCommunityIcons.playlist_music,
                    size: 32,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
