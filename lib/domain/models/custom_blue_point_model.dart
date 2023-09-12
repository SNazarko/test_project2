import 'dart:convert';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class CustomBluePointModel {
  final String remoteId;
  final String localName;
  final String type;
  final int rssi;

  const CustomBluePointModel({
    required this.remoteId,
    required this.localName,
    required this.type,
    required this.rssi,
  });

  factory CustomBluePointModel.fromBlueScanResult(ScanResult scanResult) {
    return CustomBluePointModel(
      remoteId: scanResult.device.remoteId.toString(),
      localName: scanResult.device.localName,
      type: scanResult.device.type.toString(),
      rssi: scanResult.rssi,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'remoteId': remoteId,
      'localName': localName,
      'type': type,
      'rssi': rssi,
    };
  }

  factory CustomBluePointModel.fromMap(Map<String, dynamic> map) {
    return CustomBluePointModel(
      remoteId: map['remoteId'] as String,
      localName: map['localName'] as String,
      type: map['type'] as String,
      rssi:  map['rssi'] as int,
    );
  }

  static String toStringBluePointList(
      List<CustomBluePointModel> blueAccessPoints) {
    final List<Map<String, dynamic>> blueAccessPointList =
    blueAccessPoints.map((blueAccessPoint) {
      return {
        'localName': blueAccessPoint.localName,
        'remoteId': blueAccessPoint.remoteId,
        'type': blueAccessPoint.type,
        'rssi': blueAccessPoint.rssi,
      };
    }).toList();

    final jsonString = json.encode(blueAccessPointList);
    return jsonString;
  }

  // static String toStringCustomBluePoint(
  //     CustomBluePointModel? blueAccessPoint) {
  //   if (blueAccessPoint != null) {
  //     final Map<String, dynamic> map = {
  //       'remoteId': blueAccessPoint.remoteId,
  //       'localName': blueAccessPoint.localName,
  //       'type': blueAccessPoint.type,
  //       'rssi': blueAccessPoint.rssi,
  //     };
  //     final jsonString = json.encode(map);
  //     return jsonString;
  //   } else {
  //     return '';
  //   }
  // }

  static List<CustomBluePointModel> fromStringBluePointList(
      String jsonString) {
    final List<dynamic> blueAccessPointList = json.decode(jsonString);
    return blueAccessPointList.map((map) {
      return CustomBluePointModel.fromMap(map);
    }).toList();
  }

  CustomBluePointModel copyWith({
    String? remoteId,
    String? localName,
    String? type,
    int? rssi,
  }) {
    return CustomBluePointModel(
      remoteId: remoteId ?? this.remoteId,
      localName: localName ?? this.localName,
      type: type ?? this.type,
      rssi: rssi ?? this.rssi,
    );
  }
}
