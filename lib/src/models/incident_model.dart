class IncidentModel {
  final int id;
  final String title;
  final String description;
  final String image;

  IncidentModel({ this.id, this.title, this.description, this.image });

  factory IncidentModel.fromJson(Map<String, dynamic> json) {
    return IncidentModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image']
    );
  }
}