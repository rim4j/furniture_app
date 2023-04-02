class DetailsProductModel {
  String? id;
  int? stock;
  int? price;
  List<dynamic>? colors;
  String? category;
  List<dynamic>? images;
  int? reviews;
  double? stars;
  String? name;
  String? description;
  String? company;

  DetailsProductModel({
    this.id,
    this.stock,
    this.price,
    this.colors,
    this.category,
    this.images,
    this.reviews,
    this.stars,
    this.name,
    this.description,
    this.company,
  });

  DetailsProductModel.fromJson(Map<String, dynamic> element) {
    id = element['id'];
    stock = element['stock'];
    price = element['price'];
    colors = element['colors'];
    category = element['category'];
    images = element['images'];
    reviews = element['reviews'];
    stars = element['stars'];
    name = element['name'];
    description = element['description'];
    company = element['company'];
  }
}
