
class Category {
  final String id;
  final String name;
  final String imageUrl;
  Category.fromJson(Map<String, Object> json)
      : this(
            id: json['id']! as String,
            name: json['name']! as String,
            imageUrl: json['imageUrl']! as String);

  Map<String, Object> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
  });
}
