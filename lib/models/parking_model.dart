class ParkingModel {
  final String id;
  final String name;
  final String image;
  final double lat;
  final double long;

  ParkingModel({
    required this.id,
    required this.name,
    required this.image,
    required this.lat,
    required this.long,
  });

  factory ParkingModel.fromJson(Map<String, dynamic> json) {
    return ParkingModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      long: (json['long'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'lat': lat,
      'long': long,
    };
  }

  /// 🔹 copyWith metodi — mavjud modelni yangilash uchun
  ParkingModel copyWith({
    String? id,
    String? name,
    String? image,
    double? lat,
    double? long,
  }) {
    return ParkingModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }
}
