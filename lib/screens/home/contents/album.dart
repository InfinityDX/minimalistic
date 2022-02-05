import 'package:flutter/material.dart';
import 'package:minimalmusic/widgets/betterlisttile.dart';

class Album extends StatefulWidget {
  const Album({Key? key}) : super(key: key);

  @override
  State<Album> createState() => _AlbumState();
}

class _AlbumState extends State<Album> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('Work In Progress...'),
    ));

    return ListView.separated(
      itemCount: 52,
      separatorBuilder: (context, index) {
        if (index == 0) return const SizedBox(height: 0);
        return const SizedBox(height: 10);
      },
      itemBuilder: (context, index) {
        if (index == 0) {
          return const SizedBox(height: 75);
        }
        if (index == 51) {
          return const SizedBox(height: 65);
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: BetterListTile(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(2, 2),
                blurRadius: 5,
              )
            ],
            borderRadius: BorderRadius.circular(15),
            leading: Container(
              height: 55,
              width: 55,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/20200712_005054.jpg'),
                ),
              ),
            ),
            title: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Song title',
                style: TextStyle(
                  fontFamily: 'SplineSans',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            subtitle: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Song subtitle',
                style: TextStyle(
                  fontFamily: 'SplineSans',
                  fontSize: 11,
                ),
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(
                width: 30,
                height: 30,
                child: TextButton(
                  onPressed: () {},
                  child: const Icon(Icons.more_vert),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
