import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  final String _baseUrl = 'https://fakestoreapi.com';

  Future<List<Product>> fetchProducts() async {
    final uri = Uri.parse('$_baseUrl/products');
    final resp = await http.get(uri);

    if (resp.statusCode == 200) {
      final List<dynamic> body = json.decode(resp.body) as List<dynamic>;
      return body.map((e) => Product.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to fetch products: ${resp.statusCode}');
    }
  }
}
