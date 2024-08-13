


import 'dart:convert';

class ProductModel {

    final int? id;
    final String? title;
    final dynamic price;
    final String? category;
    final String? description;
    final String? image;

    ProductModel({
        this.id,
        this.title,
        this.price,
        this.category,
        this.description,
        this.image,
    });

    ProductModel copyWith({
        int? id,
        String? title,
        dynamic price,
        String? category,
        String? description,
        String? image,
    }) => 
        ProductModel(
            id: id ?? this.id,
            title: title ?? this.title,
            price: price ?? this.price,
            category: category ?? this.category,
            description: description ?? this.description,
            image: image ?? this.image,
        );

    factory ProductModel.fromJson(String str) => ProductModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        price: json["price"] ,
        category: json["category"],
        description: json["description"],
        image: json["image"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "price": price,
        "category": category,
        "description": description,
        "image": image,
    };
}
