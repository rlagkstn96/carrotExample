import 'dart:typed_data';

import 'package:beamer/beamer.dart';
import 'package:carrotexample/constants/common_size.dart';
import 'package:carrotexample/data/item_model.dart';
import 'package:carrotexample/repo/image_storage.dart';
import 'package:carrotexample/repo/item_service.dart';
import 'package:carrotexample/router/locations.dart';
import 'package:carrotexample/screens/input/milti_image_select.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:provider/provider.dart';

import '../../states/category_notifier.dart';
import '../../states/select_image_notifier.dart';
import '../../states/user_notifier.dart';
import '../../utils/logger.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  bool _suggetestPriceSelected = false;
  TextEditingController _priceControlloer = TextEditingController();
  String? priceInput;
  var _border =
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent));
  var _divider = Divider(
    height: 1,
    thickness: 1,
    color: Colors.grey[350],
    indent: common_padding,
    endIndent: common_padding,
  );

  bool isCreatingItem = false;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _detailContrloller = TextEditingController();

  void attempCreateItem() async {
    if (FirebaseAuth.instance.currentUser == null) return;
    isCreatingItem = true;
    setState(() {});

    final String userKey = FirebaseAuth.instance.currentUser!.uid;
    final String itemKey = ItemModel.generateItemKey(userKey);

    List<Uint8List> images = context.read<SelectImageNotifier>().images;

    UserNotifier userNotifier = context.read<UserNotifier>();

    if (userNotifier.userModel == null) return;

    List<String> downloadUrls =
        await ImageStorage.uploadImages(images, itemKey);

    final num? price = num.tryParse(
        _priceControlloer.text.replaceAll('.', '').replaceAll('원', ''));

    ItemModel itemModel = ItemModel(
      itemKey: itemKey,
      userKey: userKey,
      imageDownloadUrls: downloadUrls,
      title: _titleController.text,
      category: context.read<CategoryNotifier>().currentCategoryInEng,
      price: price ?? 0,
      negotiable: _suggetestPriceSelected,
      detail: _detailContrloller.text,
      address: userNotifier.userModel!.address,
      geoFirePoint: userNotifier.userModel!.geoFirePoint,
      createdDate: DateTime.now().toUtc(),
    );

    logger.d('upload complete');

    await ItemService().createNewItem(itemModel.toJson(), itemKey);

    isCreatingItem = false;
    setState(() {
      context.beamBack();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      Size _size = MediaQuery.of(context).size;

      return IgnorePointer(
        ignoring: isCreatingItem,
        child: Scaffold(
          appBar: AppBar(
            leading: TextButton(
                onPressed: () {
                  context.beamBack();
                },
                style: TextButton.styleFrom(
                    primary: Colors.black87,
                    backgroundColor:
                        Theme.of(context).appBarTheme.backgroundColor),
                child: Text(
                  '뒤로',
                  style: Theme.of(context).textTheme.bodyText2,
                )),
            bottom: PreferredSize(
                preferredSize: Size(_size.width, 2),
                child: isCreatingItem
                    ? LinearProgressIndicator(
                        minHeight: 2,
                      )
                    : Container()),
            title: Center(
                child: Text(
              '중고거래 글쓰기',
              style: Theme.of(context).textTheme.headline6,
            )),
            actions: [
              TextButton(
                  onPressed: attempCreateItem,
                  style: TextButton.styleFrom(
                      primary: Colors.black87,
                      backgroundColor:
                          Theme.of(context).appBarTheme.backgroundColor),
                  child: Text(
                    '완료',
                    style: Theme.of(context).textTheme.bodyText2,
                  ))
            ],
          ),
          body: ListView(
            children: [
              MultiimageSelect(),
              _divider,
              TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: '글 제목',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: common_padding),
                    border: _border,
                    enabledBorder: _border,
                    focusedBorder: _border,
                  )),
              _divider,
              ListTile(
                dense: true,
                title: Text(
                    context.watch<CategoryNotifier>().currentCategoryInKor),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  context.beamToNamed('/$LOCATION_INPUT/$LOCATION_CATEGORY_INPUT');
                },
              ),
              _divider,
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: common_padding),
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _priceControlloer,
                        onChanged: (value) {
                          if (value == '0원') {
                            _priceControlloer.clear();
                          }
                          setState(() {
                            priceInput = value;
                          });
                        },
                        inputFormatters: [
                          MoneyInputFormatter(
                              mantissaLength: 0, trailingSymbol: '원')
                        ],
                        decoration: InputDecoration(
                          hintText: '얼마에 파시겠어요?',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: common_small_padding,
                              horizontal: common_small_padding),
                          prefixIcon: Icon(Icons.attach_money_rounded,
                              size: 20,
                              color: (_priceControlloer.text.isEmpty)
                                  ? Colors.grey[350]
                                  : Colors.black87),
                          prefixIconConstraints: BoxConstraints(maxWidth: 20),
                          border: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                        )),
                  )),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _suggetestPriceSelected = !_suggetestPriceSelected;
                      });
                    },
                    icon: Icon(
                      _suggetestPriceSelected
                          ? Icons.check_circle
                          : Icons.check_circle_outline,
                      color: _suggetestPriceSelected
                          ? Theme.of(context).primaryColor
                          : Colors.black54,
                    ),
                    label: Text(
                      '가격제안 받기',
                      style: TextStyle(
                        color: _suggetestPriceSelected
                            ? Theme.of(context).primaryColor
                            : Colors.black54,
                      ),
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.black54),
                  )
                ],
              ),
              _divider,
              TextFormField(
                  controller: _detailContrloller,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: '올릴 게시글 내용을 작성해세요.',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: common_padding),
                    border: _border,
                    enabledBorder: _border,
                    focusedBorder: _border,
                  )),
            ],
          ),
        ),
      );
    });
  }
}
