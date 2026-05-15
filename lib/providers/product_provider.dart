import 'package:flutter/foundation.dart';

import '../models/product.dart';
import '../services/api_service.dart';

enum ProductState { loading, loaded, error }

class ProductProvider extends ChangeNotifier {
  final ApiService _apiService;

  List<Product> products = [];
  ProductState state = ProductState.loading;
  String? errorMessage;

  ProductProvider({ApiService? apiService}) : _apiService = apiService ?? ApiService() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    state = ProductState.loading;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await _apiService.fetchProducts();
      products = result;
      state = ProductState.loaded;
    } catch (e) {
      errorMessage = e.toString();
      state = ProductState.error;
    }

    notifyListeners();
  }
}
