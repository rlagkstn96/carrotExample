import 'package:carrotexample/constants/common_size.dart';
import 'package:carrotexample/states/user_notifier.dart';
import 'package:carrotexample/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IntroPage extends StatelessWidget {
  IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;

        final sizeOfPosImg = size.width * 0.1;
        final imgSize = size.width - 32;

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: common_padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '토마토마켓',
                  style: TextStyle(
                    fontSize: 35,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Stack(children: [
                  ExtendedImage.asset('assets/imgs/carrot_intro.png'),
                  Positioned(
                    width: sizeOfPosImg,
                    left: (size.width - 32) * 0.45,
                    top: imgSize * 0.45,
                    height: sizeOfPosImg,
                    child:
                        ExtendedImage.asset('assets/imgs/carrot_intro_pos.png'),
                  )
                ]),
                Text(
                  '우리 동네 중고 직거래 토마토마켓',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  '토마토마켓은 동네 직거래 마켓이에요.\n 내 동네를 설정하고 시작해보세요!',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextButton(
                      onPressed: () async {
                        context.read<PageController>().animateToPage(1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease);
                      },
                      child: Text(
                        '내 동네 설정하고 시작하기',
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
