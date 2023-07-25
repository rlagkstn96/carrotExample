import 'package:carrotexample/screens/home_screen.dart';
import 'package:carrotexample/screens/start/address_page.dart';
import 'package:carrotexample/screens/start/auth_page.dart';
import 'package:carrotexample/screens/start/intro_page.dart';
import 'package:carrotexample/screens/start/test_notice_board.dart';
import 'package:carrotexample/screens/start/test_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatelessWidget {
  StartScreen({Key? key}) : super(key: key);

  PageController _pageController =
      PageController(); //viewportFraction: 0.7 옆페이지 특정 비율만 보기
  @override
  Widget build(BuildContext context) {
    return Provider<PageController>.value(
      value: _pageController,
      child: Scaffold(
        body: PageView(controller: _pageController,
            // physics: NeverScrollableScrollPhysics(),
            children: [
              IntroPage(),
              AddressPage(),
              AuthPage(),
              HomeScreen(),
              // TestPage(),
              // TestNoticeBoard(),
            ]),
      ),
    );
  }
}
