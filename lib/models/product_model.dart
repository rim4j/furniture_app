class ProductModel {
  String? id;
  String? name;
  int? price;
  String? image;
  List<dynamic>? colors;
  String? company;
  String? description;
  String? category;
  bool? shipping;

  ProductModel({
    this.id,
    this.name,
    this.price,
    this.image,
    this.colors,
    this.company,
    this.description,
    this.category,
    this.shipping,
  });

  ProductModel.fromJson(Map<String, dynamic> element) {
    id = element["id"];
    name = element["name"];
    price = element["price"];
    image = element["image"];
    colors = element["colors"];
    company = element["company"];
    description = element["description"];
    category = element["category"];
    shipping = element["shipping"];
  }
}


//!key value in the api request
// id: "recZkNf2kwmdBcqd0",
// name: "accent chair",
// price: 25999,
// image: "https://images2.imgbox.com/38/85/iuYyO9RP_o.jpeg",
// colors: [
// "#ff0000",
// "#00ff00",
// "#0000ff"
// ],
// company: "marcos",
// description: "Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge",
// category: "office",
// shipping: true