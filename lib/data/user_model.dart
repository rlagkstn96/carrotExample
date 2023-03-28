import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class UserModel {
  late String userKey;
  late String PhoneNumber;
  late String address;
  late GeoFirePoint geoFirePoint;
  late DateTime createDate;
  DocumentReference? reference;

  UserModel({
    required this.userKey,
    required this.PhoneNumber,
    required this.address,
    required this.geoFirePoint,
    required this.createDate,
    this.reference,
  });

  UserModel.fromJson(Map<String, dynamic> json, this.userKey, this.reference)
      : PhoneNumber = json['PhoneNumber'],
        address = json['address'],
        geoFirePoint = GeoFirePoint((json['geoFirePoint']['geopoint']).latitude,
            (json['geoFirePoint']['geopoint']).longitude),
        createDate = json['createDate'] == null
            ? DateTime.now().toUtc()
            : (json['createDate'] as Timestamp).toDate();

  UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data()!, snapshot.id, snapshot.reference);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PhoneNumber'] = PhoneNumber;
    map['address'] = address;
    map['geoFirePoint'] = geoFirePoint.data;
    map['createDate'] = createDate;
    return map;
  }
}
