class SingleProduct {
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

  SingleProduct(
      this.id,
      this.title,
      this.description,
      this.price,
      this.discountPercentage,
      this.rating,
      this.stock,
      this.brand,
      this.category,
      this.thumbnail,
      this.images);

  factory SingleProduct.fromJson(Map<String, dynamic> data) {
    return SingleProduct(
        data['id'],
        data['title'],
        data['description'],
        data['price'],
        data['discountPercentage'],
        data['rating'],
        data['stock'],
        data['brand'],
        data['category'],
        data['thumbnail'],
        (data['images'] as List<dynamic>).map((e) => e.toString()).toList());
  }
}
