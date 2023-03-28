import 'package:carrotexample/constants/common_size.dart';
import 'package:carrotexample/repo/user_service.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;
        final imgSize = size.width / 4;

        return FutureBuilder(
            future: Future.delayed(Duration(seconds: 2)),
            builder: (context, snapshot) {
              return AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: (snapshot.connectionState != ConnectionState.done)
                      ? _shimmerListView(imgSize)
                      : _listView(imgSize));
            });
      },
    );
  }

  ListView _listView(double imgSize) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider(
          height: common_padding + 2 + 1,
          thickness: 1,
          color: Colors.grey[200],
          indent: common_padding,
          endIndent: common_padding,
        );
      },
      itemCount: 10,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            UserService().firestoreReadTest();
          },
          child: SizedBox(
            height: imgSize,
            child: Row(
              children: [
                SizedBox(
                    height: imgSize,
                    width: imgSize,
                    child: ExtendedImage.network('https://picsum.photos/100',
                        borderRadius: BorderRadius.circular(12),
                        shape: BoxShape.rectangle)),
                SizedBox(width: common_small_padding),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'work',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      '53일전',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text('5000원'),
                    Expanded(
                      child: Container(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 14,
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Row(
                              children: [
                                Icon(CupertinoIcons.chat_bubble_2,
                                    color: Colors.grey),
                                Text('23',
                                    style: TextStyle(color: Colors.grey)),
                                Icon(CupertinoIcons.heart, color: Colors.grey),
                                Text('30',
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _shimmerListView(double imgSize) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: true,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(
            height: common_padding + 2 + 1,
            thickness: 1,
            color: Colors.grey[200],
            indent: common_padding,
            endIndent: common_padding,
          );
        },
        itemCount: 10,
        itemBuilder: (context, index) {
          return SizedBox(
            height: imgSize,
            child: Row(
              children: [
                Container(
                    height: imgSize,
                    width: imgSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                    )),
                SizedBox(width: common_small_padding),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 14, width: 150, color: Colors.white),
                    SizedBox(height: 4),
                    Container(height: 12, width: 180, color: Colors.white),
                    SizedBox(height: 4),
                    Container(height: 14, width: 100, color: Colors.white),
                    SizedBox(height: 4),
                    Expanded(
                      child: Container(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 14,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ],
                    )
                  ],
                ))
              ],
            ),
          );
        },
      ),
    );
  }
}
