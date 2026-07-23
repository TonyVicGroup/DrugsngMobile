import 'package:drugs_ng/core/services/rest_service.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/search/data/models/search_item.dart';

class SearchDatasource {
  final RestService service = RestService(baseUrl: AppUtils.baseUrl);

  Future<List<SearchItem>> diagnosticTest(String query) async {
    final response = await service.get(
      path: "test/similar-tests",
      params: {"testName": query},
    );
    if (response.hasError) throw response.error;
    final packages = List.from(
      response.data!['data'],
    ).map((pkg) => SearchItem.fromJson(pkg, SearchType.diagnosticTest));
    return packages.toList();
  }

  Future<List<SearchItem>> product(String query) async {
    final response = await service.get(
      path: "product/similar-products",
      params: {"productName": query},
    );
    if (response.hasError) throw response.error;
    final packages = List.from(
      response.data!['data'],
    ).map((pkg) => SearchItem.fromJson(pkg, SearchType.product));
    return packages.toList();
  }

  Future<List<SearchItem>> wellnessPackage(String query) async {
    final response = await service.get(
      path: "wellnessPackage/similar-packages",
      params: {"packageName": query},
    );
    if (response.hasError) throw response.error;
    final packages = List.from(
      response.data!['data'],
    ).map((pkg) => SearchItem.fromJson(pkg, SearchType.wellnessPackage));
    return packages.toList();
  }

  Future<List<SearchItem>> testAndPackage(String query) async {
    final responsePackage = await service.get(
      path: "wellnessPackage/similar-packages",
      params: {"packageName": query},
    );
    if (responsePackage.hasError) throw responsePackage.error;
    final responseTest = await service.get(
      path: "test/similar-tests",
      params: {"testName": query},
    );
    if (responseTest.hasError) throw responsePackage.error;
    final tests = List.from(
      responseTest.data!['data'],
    ).map((tst) => SearchItem.fromJson(tst, SearchType.diagnosticTest));

    final packages = List.from(
      responsePackage.data!['data'],
    ).map((pkg) => SearchItem.fromJson(pkg, SearchType.wellnessPackage));
    return [...tests, ...packages];
  }

  Future<List<SearchItem>> all(String query) async {
    final responseProduct = await service.get(
      path: "product/similar-products",
      params: {"productName": query},
    );
    // final responsePackage = await service.get(
    //   path: "wellnessPackage/similar-packages",
    //   params: {"packageName": query},
    // );
    // final responseTest = await service.get(
    //   path: "test/similar-tests",
    //   params: {"testName": query},
    // );
    if (responseProduct.hasError) throw responseProduct.error;
    List<SearchItem> allProducts = [];
    final products = List.from(
      responseProduct.data!['data'],
    ).map((prod) => SearchItem.fromJson(prod, SearchType.product));
    // final tests = List.from(responseTest.data!['data'])
    //     .map((tst) => SearchItem.fromJson(tst, SearchType.diagnosticTest));
    // final packages = List.from(responsePackage.data!['data'])
    //     .map((pkg) => SearchItem.fromJson(pkg, SearchType.wellnessPackage));
    allProducts.addAll(products);
    // allProducts.addAll(tests);
    // allProducts.addAll(packages);
    return allProducts;
  }
}
