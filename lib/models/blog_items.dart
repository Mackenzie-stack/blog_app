class Blogitems {
  final String kind;
  final String description;
  final String name;

  const Blogitems({
    required this.kind,
    required this.description,
    required this.name,
  });

  factory Blogitems.fromJson(Map<String, dynamic> json) {
    return Blogitems(
      kind: json['userId'],
      description: json['id'],
      name: json['title'],
    );
  }
}
