
class Ad {
  final String id;

  final String title;
  final String description;
  final String imageUrl; // Add this property
  Ad.fromJson(Map<String, Object> json)
      : this(
            id: json['id']! as String,
            title: json['title']! as String,
            description: json["description"]! as String,
            imageUrl: json['imageUrl']! as String);

  Map<String, Object> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  Ad({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}
