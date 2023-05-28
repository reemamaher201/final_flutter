class Book {
  int? id;
  String? name;
  String? author;
  String? image;
  String? description;
  String? date;

  Book({
    this.id,
    this.name,
    this.author,
    this.image,
    this.description,
    this.date

  });

  // Named constructor
  Book.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    author = map['author'];
    image = map['image']; // تعيين قيمة الصورة من الخريطة
    description = map['description'];
    date = map['date'];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "author": author,
      "image": image, // إضافة الصورة إلى الخريطة
      "description": description,
      "date": date
    };
  }
}
