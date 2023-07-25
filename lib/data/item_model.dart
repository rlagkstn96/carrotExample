import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class ItemModel {
  late String itemKey;
  late String userKey;
  late List<String> imageDownloadUrls;
  late String title;
  late String category;
  late num price;
  late bool negotiable;
  late String detail;
  late String address;
  late GeoFirePoint geoFirePoint;
  late DateTime createdDate;
  late DocumentReference? reference;

  ItemModel({
    required this.itemKey,
    required this.userKey,
    required this.imageDownloadUrls,
    required this.title,
    required this.category,
    required this.price,
    required this.negotiable,
    required this.detail,
    required this.address,
    required this.geoFirePoint,
    required this.createdDate,
    this.reference
  });

  ItemModel.fromJson(Map<String, dynamic> json, this.itemKey, this.reference) {
    itemKey = json['itemKey'] ?? "";
    userKey = json['userKey'] ?? "";
    imageDownloadUrls = json['imageDownloadUrls'] != null
        ? json['imageDownloadUrls'].cast<String>()
        : [];
    title = json['title'] ?? "";
    category = json['category'] ?? "none";
    price = json['price'] ?? 0;
    negotiable = json['negotiable'] ??false;
    detail = json['detail'] ?? "";
    address = json['address'] ?? "";
    geoFirePoint =  GeoFirePoint((json['geoFirePoint']['geopoint']).latitude,
        (json['geoFirePoint']['geopoint']).longitude);
    createdDate = json['createDate'] == null
        ? DateTime.now().toUtc()
        : (json['createDate'] as Timestamp).toDate();
  }

  ItemModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data()!, snapshot.id, snapshot.reference);

  ItemModel.fromQuerySnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.id, snapshot.reference);

  Map<String, dynamic> toJson() { //모든 데이터 추출 및 모델로 만들어서 저장소에 보낼때 사용
    final map = <String, dynamic>{};
    map['userKey'] = userKey;
    map['imageDownloadUrls'] = imageDownloadUrls;
    map['title'] = title;
    map['category'] = category;
    map['price'] = price;
    map['negotiable'] = negotiable;
    map['detail'] = detail;
    map['address'] = address;
    map['geoFirePoint'] = geoFirePoint.data;
    map['createdDate'] = createdDate;
    return map;
  }

  static String generateItemKey(String uid){
    String timeInMilli = DateTime.now().millisecondsSinceEpoch.toString();
    return '${uid}_$timeInMilli';
  }
}
