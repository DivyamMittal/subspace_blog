import 'package:hive/hive.dart';
import 'package:subspace_blog/model/blog_model.dart';

class BlogModelAdapter extends TypeAdapter<BlogModel> {
  @override
  final int typeId = 0; // Unique identifier for this type

  @override
  BlogModel read(BinaryReader reader) {
    return BlogModel(
      id: reader.readString(),
      imageUrl: reader.readString(),
      title: reader.readString(),
    )..isFavourite = reader.readBool(); // Read the isFavourite property
  }

  @override
  void write(BinaryWriter writer, BlogModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.imageUrl);
    writer.writeString(obj.title);
    writer.writeBool(obj.isFavourite); // Write the isFavourite property
  }
}
