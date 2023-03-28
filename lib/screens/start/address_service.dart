import 'dart:math';

import 'package:carrotexample/data/AddressModel.dart';
import 'package:carrotexample/data/AddressModel2.dart';
import 'package:carrotexample/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:carrotexample/constants/keys.dart';

class AddressService {
  Future<AddressModel> searchAddressByStr(String text) async {
    final formData = {
      'key': VWORLD_KEY,
      'request': 'search',
      'size': 30,
      'query': text,
      'type': 'address',
      'category': 'ROAD',
    };

    final response = await Dio()
        .get('http://api.vworld.kr/req/search', queryParameters: formData)
        .catchError((e) {
      logger.e(e.message);
    });

    AddressModel addressModel = AddressModel.fromJson(response.data["response"]); //Address Json Model은 JsonToDart 플러그인을 활용하여 클래스를 생성함.
    return addressModel;
  }

  Future<List<AddressModel2>> findAddressByCoordinate({required double lng, required double lat}) async {
    final List<Map<String, dynamic>> formDatas = <Map<String, dynamic>>[];

    formDatas.add({
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'getAddress',
      'type' : 'PARCEL',
      'point' : '$lng,$lat',
    });

    formDatas.add({
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'getAddress',
      'type' : 'PARCEL',
      'point' : '${lng-0.01},$lat',
    });

    formDatas.add({
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'getAddress',
      'type' : 'PARCEL',
      'point' : '${lng+0.01},$lat',
    });

    formDatas.add({
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'getAddress',
      'type' : 'PARCEL',
      'point' : '${lng-0.01},${lat-0.01}',
    });

    formDatas.add({
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'getAddress',
      'type' : 'PARCEL',
      'point' : '${lng+0.01},${lat+0.01}',
    });

    List<AddressModel2> addresses = [];

    for (Map<String, dynamic> formData in formDatas) {
      final response = await Dio()
          .get('http://api.vworld.kr/req/address', queryParameters: formData)
          .catchError((e) {
        logger.e(e.message);
      });
      AddressModel2 addressModel = AddressModel2.fromJson(response.data["response"]);
      if(response.data['response']['status'] == 'OK' ) addresses.add((addressModel));
    }
    return addresses;
  }
}
