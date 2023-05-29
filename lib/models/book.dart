class Book {
  int? id;
  String? name;
  String? author;
  String? image;
  String? description;
  String? date;
  bool? isFavorite;

  Book({
    this.id,
    this.name,
    this.author,
    this.image,
    this.description,
    this.date,
    this.isFavorite = false

  });

  // Named constructor
  Book.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    author = map['author'];
    image = map['image']; // تعيين قيمة الصورة من الخريطة
    description = map['description'];
    date = map['date'];
    isFavorite = map['isFavorite'] ==1 ;
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "author": author,
      "image": image, // إضافة الصورة إلى الخريطة
      "description": description,
      "date": date,
      "isFavorite": isFavorite
    };
  }
}
