import 'package:carrotexample/constants/common_size.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class TestNoticeBoard extends StatelessWidget {
  TestNoticeBoard({Key? key}) : super(key: key);

  void onButtonClick() async {}
  final messages = '민법상 계약체결일은 계약서 작성일·교부일이 아닌 거래 당사자 간 계약의 중요사항이 합치된 날을 의미한다. 그러나 시장에서는 관례적으로 계약서를 쓴 날짜를 기준으로 신고기한을 계산해 과태료 처분을 받는 경우가 많았다. 현행법에 따르면 계약체결일로부터 30일 이내 거래신고 하지 않으면 500만원 이하, 거짓신고로 분류되면 취득가액의 2% 이하의 과태료 처분을 받는다.';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text('임대인 라운지'),
            bottom: const TabBar(
              tabs: [
                Tab(text: '자유게시판'),
                Tab(text: '자문구하기'),
                Tab(text: '부동산 시장'),
                Tab(text: '토론'),
              ],
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Hero(
                tag: 'ListTile-Hero',
                // Wrap the ListTile in a Material widget so the ListTile has someplace
                // to draw the animated colors during the hero transition.
                child: Material(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: const Text('부동산 임대차 계약 어떻게 진행하세요?'),
                      subtitle: Text('$messages'),
                      tileColor: Colors.white,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.black)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<Widget>(
                              builder: (BuildContext context) {
                            return Scaffold(
                              appBar: AppBar(title: const Text('ListTile Hero')),
                              body: Center(
                                child: Hero(
                                  tag: 'ListTile-Hero',
                                  child: Material(
                                    child: ListTile(
                                      title: const Text('ListTile with Hero'),
                                      subtitle: const Text('Tap here to go back'),
                                      tileColor: Colors.blue[700],
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.red,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.forum),
                label: 'forum',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sensor_door_rounded),
                label: 'space',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'setting',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
