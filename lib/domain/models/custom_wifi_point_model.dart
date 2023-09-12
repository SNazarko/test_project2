import 'dart:convert';

import 'package:wifi_scan/wifi_scan.dart';

class CustomWifiPointModel{
  final String bssid;
  final String capabilities;
  final int? centerFrequency0;
  final int? centerFrequency1;
  final int frequency;
  final bool? is80211mcResponder;
  final bool? isPasspoint;
  final int level;
  final String? operatorFriendlyName;
  final String ssid;
  final int? timestamp;
  final String? venueName;

  const CustomWifiPointModel({
    required this.bssid,
    required this.capabilities,
    this.centerFrequency0,
    this.centerFrequency1,
    required this.frequency,
    this.is80211mcResponder,
    this.isPasspoint,
    required this.level,
    this.operatorFriendlyName,
    required this.ssid,
    this.timestamp,
    this.venueName,
  });

  Map<String, dynamic> toMap() {
    return {
      'bssid': bssid,
      'capabilities': capabilities,
      'centerFrequency0': centerFrequency0,
      'centerFrequency1': centerFrequency1,
      'frequency': frequency,
      'is80211mcResponder': is80211mcResponder == true ? 1 : 0,
      'isPasspoint': isPasspoint == true ? 1 : 0,
      'level': level,
      'operatorFriendlyName': operatorFriendlyName,
      'ssid': ssid,
      'timestamp': timestamp,
      'venueName': venueName,
    };
  }

  factory CustomWifiPointModel.fromMap(Map<String, dynamic> map) {
    return CustomWifiPointModel(
      bssid: map['bssid'] as String,
      capabilities: map['capabilities'] as String,
      centerFrequency0: map['centerFrequency0'] as int,
      centerFrequency1: map['centerFrequency1'] as int,
      frequency: map['frequency'] as int,
      is80211mcResponder: map['is80211mcResponder'] == 1,
      isPasspoint: map['isPasspoint'] == 1,
      level: map['level'] as int,
      operatorFriendlyName: map['operatorFriendlyName'] as String,
      ssid: map['ssid'] as String,
      timestamp: map['timestamp'] as int,
      venueName: map['venueName'] as String,
    );
  }
  factory CustomWifiPointModel.fromWiFiAccessPoint(WiFiAccessPoint wifiAccessPoint) {
    return CustomWifiPointModel(
      ssid: wifiAccessPoint.ssid,
      bssid: wifiAccessPoint.bssid,
      capabilities: wifiAccessPoint.capabilities,
      level: wifiAccessPoint.level,
      frequency: wifiAccessPoint.frequency,
      centerFrequency0: wifiAccessPoint.centerFrequency0,
      centerFrequency1: wifiAccessPoint.centerFrequency1,
      timestamp: wifiAccessPoint.timestamp,
      isPasspoint: wifiAccessPoint.isPasspoint,
      operatorFriendlyName: wifiAccessPoint.operatorFriendlyName,
      venueName: wifiAccessPoint.venueName,
      is80211mcResponder: wifiAccessPoint.is80211mcResponder,
    );
  }

  static String toStringWiFiPointList(
      List<CustomWifiPointModel> wifiAccessPoints) {
    final List<Map<String, dynamic>> wifiAccessPointList =
    wifiAccessPoints.map((wifiAccessPoint) {
      return {
        'ssid': wifiAccessPoint.ssid,
        'bssid': wifiAccessPoint.bssid,
        'capabilities': wifiAccessPoint.capabilities,
        'level': wifiAccessPoint.level,
        'frequency': wifiAccessPoint.frequency,
        'centerFrequency0': wifiAccessPoint.centerFrequency0,
        'centerFrequency1': wifiAccessPoint.centerFrequency1,
        'timestamp': wifiAccessPoint.timestamp,
        'isPasspoint': wifiAccessPoint.isPasspoint,
        'operatorFriendlyName': wifiAccessPoint.operatorFriendlyName,
        'venueName': wifiAccessPoint.venueName,
        'is80211mcResponder': wifiAccessPoint.is80211mcResponder,
      };
    }).toList();

    final jsonString = json.encode(wifiAccessPointList);
    return jsonString;
  }

  static String toStringCustomWiFiPoint(
      CustomWifiPointModel? wifiAccessPoint) {
    if (wifiAccessPoint != null) {
      final Map<String, dynamic> map = {
        'ssid': wifiAccessPoint.ssid,
        'bssid': wifiAccessPoint.bssid,
        'capabilities': wifiAccessPoint.capabilities,
        'level': wifiAccessPoint.level,
        'frequency': wifiAccessPoint.frequency,
        'centerFrequency0': wifiAccessPoint.centerFrequency0,
        'centerFrequency1': wifiAccessPoint.centerFrequency1,
        'timestamp': wifiAccessPoint.timestamp,
        'isPasspoint': wifiAccessPoint.isPasspoint,
        'operatorFriendlyName': wifiAccessPoint.operatorFriendlyName,
        'venueName': wifiAccessPoint.venueName,
        'is80211mcResponder': wifiAccessPoint.is80211mcResponder,
      };
      final jsonString = json.encode(map);
      return jsonString;
    } else {
      return '';
    }
  }

  static List<CustomWifiPointModel> fromStringWiFiPointList(
      String jsonString) {
    try {
      final List<dynamic> wifiAccessPointList = json.decode(jsonString);
      return wifiAccessPointList.map((map) {
        return CustomWifiPointModel.fromMap(map);
      }).toList();
    } catch (_) {
      return <CustomWifiPointModel>[];
    }
  }

  static CustomWifiPointModel fromStringWiFiPoint(String jsonString) {
    final Map<String, dynamic> map = json.decode(jsonString);

    return CustomWifiPointModel.fromMap(map);
  }



  CustomWifiPointModel copyWith({
    String? bssid,
    String? capabilities,
    int? centerFrequency0,
    int? centerFrequency1,
    int? frequency,
    bool? is80211mcResponder,
    bool? isPasspoint,
    int? level,
    String? operatorFriendlyName,
    String? ssid,
    int? timestamp,
    String? venueName,
  }) {
    return CustomWifiPointModel(
      bssid: bssid ?? this.bssid,
      capabilities: capabilities ?? this.capabilities,
      centerFrequency0: centerFrequency0 ?? this.centerFrequency0,
      centerFrequency1: centerFrequency1 ?? this.centerFrequency1,
      frequency: frequency ?? this.frequency,
      is80211mcResponder: is80211mcResponder ?? this.is80211mcResponder,
      isPasspoint: isPasspoint ?? this.isPasspoint,
      level: level ?? this.level,
      operatorFriendlyName: operatorFriendlyName ?? this.operatorFriendlyName,
      ssid: ssid ?? this.ssid,
      timestamp: timestamp ?? this.timestamp,
      venueName: venueName ?? this.venueName,
    );
  }
}