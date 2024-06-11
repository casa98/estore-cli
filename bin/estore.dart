import 'package:estore/repositories/product_repository_impl.dart';
import 'package:estore/services/product_service.dart';

void main(List<String> args) async {
  final productService = ProductService();
  final productRepository = ProductRepositoryImpl(productService);

  // Get products
  final productsResult = await productRepository.getProducts();
  productsResult.fold(
    (error) => print('Error getting products: $error'),
    (products) {
      print('Products (${products.length} items):');
      for (var product in products) {
        print(product);
      }
    },
  );
  print('----------------------\n');

  // Get details of a specific product
  final productByIdResult =
      await productRepository.getProductById(productsResult.fold(
    (l) => 0,
    (r) => r.first.id,
  ));
  // Managing errors and responses with `dartz`
  productByIdResult.fold(
    (error) => print('Error getting product by ID: $error'),
    (product) => print('Product Detail:\n$product'),
  );
  print('----------------------\n');

  // Get categories
  final categoriesResult = await productRepository.getCategories();
  categoriesResult.fold(
    (error) => print('Error geting categories: $error'),
    (categories) {
      print('Categories:');
      for (var category in categories) {
        print(category);
      }
    },
  );
  print('\n----------------------\n');
}
