import 'package:carrotexample/constants/common_size.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {

  TestPage({Key? key}) : super(key: key);

  void onButtonClick() async {

  }

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
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: onButtonClick,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: Size.fromHeight(50), // 높이만 50으로 설정
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ExtendedImage.asset('assets/imgs/btn_google_light_normal_ldpi.9.png'),
                            Text(' google로 계속하기 ',
                              style: TextStyle(color: Colors.black),),
                            Opacity(
                              opacity: 0.0,
                              child: ExtendedImage.asset('assets/imgs/btn_google_light_normal_ldpi.9.png'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: common_padding,),
                      ElevatedButton(
                        onPressed: onButtonClick,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: Size.fromHeight(50), // 높이만 50으로 설정
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ExtendedImage.asset('assets/imgs/apple_login_1x.png'),
                            Text('Apple로 계속하기',
                            style: TextStyle(color: Colors.black),),
                            Opacity(
                              opacity: 0.0,
                              child: Image.asset('assets/imgs/apple_login_1x.png'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: common_padding,),
                      ElevatedButton(
                        onPressed: onButtonClick,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffFEE500),
                          minimumSize: Size.fromHeight(50), // 높이만 50으로 설정
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                        ),
                        child:
                        ExtendedImage.asset('assets/imgs/kakao_login_medium_wide.png', width: 260,),
                      ),
                      SizedBox(height: common_padding,),
                      ElevatedButton(
                        onPressed: onButtonClick,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff03C75A),
                          minimumSize: Size.fromHeight(50), // 높이만 50으로 설정
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                        ),
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ExtendedImage.asset('assets/imgs/naver_login_icon.png'),
                            Text('네이버로 시작하기',
                              style: TextStyle(color: Colors.white),),
                            Opacity(
                              opacity: 0.0,
                              child: Image.asset('assets/imgs/naver_login_icon.png'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
