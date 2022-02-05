import 'package:flutter/material.dart';
import 'package:minimalmusic/screens/welcome/welcomepage.dart';
import 'package:minimalmusic/services/appstatus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final _pageContoller = PageController(initialPage: 0);
  String buttonText = 'Next';
  String permissionText =
      'We need storage permission to discover your local music files.';
  int pageIndex = 0;
  bool swtichBtnToGrant = false;
  AppStatus? _appStatus;

  @override
  Widget build(BuildContext context) {
    _appStatus = Provider.of<AppStatus>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: PageView(
                controller: _pageContoller,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const WelcomePage(
                    topText1: 'Welcome',
                    topText2: 'Minimal Music',
                    svgImagePath: 'assets/svgs/Welcome-01.svg',
                    subtitle: 'Begin your epic music journey.',
                  ),
                  WelcomePage(
                    topText1: 'Almost There!',
                    topText2: 'Permissions',
                    svgImagePath: 'assets/svgs/Welcome-02.svg',
                    subtitle: permissionText,
                  ),
                  const WelcomePage(
                    topText1: 'Perfect!',
                    topText2: 'Let\'s Begin',
                    svgImagePath: 'assets/svgs/Welcome-03.svg',
                    subtitle: 'To a world of music.',
                  ),
                ],
              ),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: _pageContoller,
                count: 3,
                effect: ExpandingDotsEffect(
                  activeDotColor: Colors.deepPurple.shade900,
                  dotColor: Colors.deepPurple.shade300,
                  dotHeight: 10,
                  dotWidth: 10,
                  expansionFactor: 3,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 20),
              child: TextButton(
                onPressed: swtichBtnToGrant ? btnGrant : btnNext,
                child: Text(buttonText),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.deepPurple[900]),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void btnGrant() async {
    var permStatus = await Permission.storage.request();
    if (permStatus.isGranted) {
      setState(() {
        buttonText = 'Next';
        permissionText = 'Permission Granted!\n Let\'s Proceed.';
        swtichBtnToGrant = false;
      });
    } else if (permStatus.isDenied) {
      setState(() {
        permissionText = 'Please choose allow to continue.';
      });
    }
  }

  void btnNext() {
    if (pageIndex == 2) {
      _appStatus!.removeOnBoardScreen();
      return;
    }
    _pageContoller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    setState(() {
      pageIndex = pageIndex >= 2 ? 2 : pageIndex + 1;
      if (pageIndex == 1) {
        buttonText = 'Grant Permission';
        swtichBtnToGrant = true;
      } else if (pageIndex == 2) {
        buttonText = 'Begin The Journey';
      }
    });
  }
}
