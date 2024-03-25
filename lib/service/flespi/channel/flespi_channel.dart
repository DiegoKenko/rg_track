class FlespiChannel {
  String name;
  int protocolId;
  int? id;
  int? cid;
  String? uri;
  bool? enable = true;
  String? host;
  String? port;
  FlespiChannel({
    required this.name,
    required this.protocolId,
    this.id,
    this.cid,
    this.enable,
    this.host,
    this.uri,
    this.port,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'protocol_id': protocolId,
      'configuration': {},
    };
  }

  factory FlespiChannel.fromMap(Map<String, dynamic> map) {
    return FlespiChannel(
      protocolId: map['protocol_id'] ?? 0,
      name: map['name'] ?? '',
      id: map['id'],
      cid: map['cid'],
      uri: map['uri'],
      host: (map['uri'] as String?)?.split(':').first ?? '',
      port: (map['uri'] as String?)?.split(':').last ?? '',
    );
  }
}
