// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final productsProvider = FutureProvider<List<Product>>((ref) async {
  final res = await GetIt.I.get<Supabase>().client.from('Products').select('*');
  log(res.map((e)=>Product.fromMap(e)).toList().toString());
  return res.map((e)=>Product.fromMap(e)).toList();
});

class Product {
  int id;
  String name;
  String desc;
  double price;
  String url;
  DateTime createdAt;
  Product({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.url,
    required this.createdAt,
  });
 

  Product copyWith({
    int? id,
    String? name,
    String? desc,
    double? price,
    String? url,
    DateTime? createdAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      desc: desc ?? this.desc,
      price: price ?? this.price,
      url: url ?? this.url,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'desc': desc,
      'price': price,
      'url': url,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      name: map['name'] as String,
      desc: map['desc'] as String,
      price: map['price'] as double,
      url: map['url'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, desc: $desc, price: $price, url: $url, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.desc == desc &&
      other.price == price &&
      other.url == url &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      desc.hashCode ^
      price.hashCode ^
      url.hashCode ^
      createdAt.hashCode;
  }
}
