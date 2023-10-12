class BlogModel {
  BlogModel({
    required this.id,
    required this.imageUrl,
    required this.title,
  });
  late final String id;
  late final String imageUrl;
  late final String title;
  bool isFavourite = false;

  BlogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['image_url'] = imageUrl;
    _data['title'] = title;
    return _data;
  }
}
