class ConnectModel {
  final String? wifiName;
  final String? wifiIP;

  const ConnectModel({
    this.wifiName,
    this.wifiIP,
  });

  ConnectModel copyWith({
    String? wifiName,
    String? wifiIP,
  }) {
    return ConnectModel(
      wifiName: wifiName ?? this.wifiName,
      wifiIP: wifiIP ?? this.wifiIP,
    );
  }
}