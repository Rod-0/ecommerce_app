class Product {
  final int id;
  final String name;
  

  const Product({
    required this.name,
    required this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json['name'],
        id: json['id'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  Product.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        id = map['id'];
}

class ProductImagen{
  final List<String> posters;

  const ProductImagen({
    required this.posters,
  });

  factory ProductImagen.fromJson(Map<String, dynamic> json) => ProductImagen(
        posters: json['carousel_images'].cast<String>(),
      );
  
  Map<String, dynamic> toMap(){
    return{
      'carousel_images': posters
    };
  }

  ProductImagen.fromMap(Map<String, dynamic> map)
      : posters = map['carousel_images'].cast<String>();
}
class ProductsInfo {
  final String name;
  final String category;
  final String gender;
  final int currentPrice;
  final List<String> size;
  final String type;
  final List<String> availableColors;


  const ProductsInfo(
      {required this.category,
      required this.gender,
      required this.currentPrice,
      required this.size,
      required this.type,
      required this.availableColors,
      required this.name});

  ProductsInfo.fromJson(Map<String, dynamic> json)
      : category = json['category'],
        gender = json['gender'],
        currentPrice = json['current_price'],
        size = json['size'].cast<String>(),
        type = json['type'],
        name = json['name'],
        availableColors = json['available_colors'].cast<String>();


  ProductsInfo.fromMap(Map<String,dynamic> map)
  : category = map['category'],
  gender = map['gender'],
  currentPrice = map['current_price'],
  size = map['size'].cast<String>(),
  type = map['type'],
  name = map['name'],
  availableColors = map['available_colors'].cast<String>();
  
}
