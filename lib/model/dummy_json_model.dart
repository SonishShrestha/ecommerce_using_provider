class DummyJson {
  List<Products> products;
  int total;
  int skip;
  int limit;

  DummyJson(
      {required this.products,
      required this.limit,
      required this.skip,
      required this.total});

  factory DummyJson.fromJson(Map<String, dynamic> data) {
    return DummyJson(
        products: (data['products'] as List<dynamic>)
            .map((e) => Products.fromJson(e))
            .toList(),
        limit: data['limit'],
        skip: data['skip '],
        total: data['total']);
  }
}

class Products {
  int id;
  String title;
  String description;
  int price;
  num discountPercentage;
  num rating;
  int stock;
  String brand;
  String category;
  String thumbnail;
  List<String> images;

  Products(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.discountPercentage,
      required this.rating,
      required this.stock,
      required this.brand,
      required this.category,
      required this.thumbnail,
      required this.images});

  factory Products.fromJson(Map<String, dynamic> data) {
    return Products(
        id: data['id'],
        title: data['title'],
        description: data['description'],
        price: data['price'],
        discountPercentage: data['discountPercentage'],
        rating: data['rating'],
        stock: data['stock'],
        brand: data['brand'],
        category: data['category'],
        thumbnail: data['thumbnail'],
        images: data['images']);
  }
}
