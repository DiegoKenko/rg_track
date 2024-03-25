class KindOfFuel {
  KindOfFuel({
    required this.title,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  final String title;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  factory KindOfFuel.fromMap(Map<String, dynamic> data) => KindOfFuel(
        title: data["title"],
        updatedAt: DateTime.parse(data["updated_at"]),
        createdAt: DateTime.parse(data["created_at"]),
        id: data["id"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };

  KindOfFuel copyWith({
    String? title,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
  }) {
    if ((title == null || identical(title, this.title)) &&
        (updatedAt == null || identical(updatedAt, this.updatedAt)) &&
        (createdAt == null || identical(createdAt, this.createdAt)) &&
        (id == null || identical(id, this.id))) {
      return this;
    }

    return KindOfFuel(
      title: title ?? this.title,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
    );
  }
}
