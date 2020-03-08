class WetlandModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final double latitude;
  final double longitude;
  final String location;
  final String extensionW;

  WetlandModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.latitude,
    this.longitude,
    this.location,
    this.extensionW
  });

  factory WetlandModel.fromJson(Map<String, dynamic> json) {
    return WetlandModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      location: json['location'],
      extensionW: json['extension']
    );
  }
}