import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../data/models/product_model.dart';
import '../data/services/product_service.dart';

final productProvider = StateNotifierProvider<ProductViewModel, AsyncValue<List<Product>>>(
  (ref) => ProductViewModel(ProductService()),
);

class ProductViewModel extends StateNotifier<AsyncValue<List<Product>>> {
  final ProductService _service;

  ProductViewModel(this._service) : super(const AsyncLoading()) {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final products = await _service.fetchProducts();
      state = AsyncData(products);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
