import 'package:drugs_ng/core/services/rest_service.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/auth/data/datasource/user_preference.dart';
import 'package:drugs_ng/features/checkout/data/models/address/user_address.dart';
import 'package:drugs_ng/features/checkout/data/models/state_and_city.dart';

class AddressDatasource {
  final RestService service = RestService(baseUrl: AppUtils.baseUrl);

  Future<UserAddress> addAddreses({
    required String userId,
    required UserAddress address,
  }) async {
    final response = await service.post(
      path: 'profile/user/$userId/address',
      data: address.toJson(),
    );
    if (response.hasError) throw response.error;
    return UserAddress.fromJson(
      Map<String, dynamic>.from(response.data!['data']),
    );
  }

  Future<void> deleteAddress(UserAddress address) async {
    final response = await service.delete(
      path: 'profile/user/address/${address.id}',
    );
    if (response.hasError) {
      throw response.error;
    }
    return;
  }

  Future<UserAddress> editAddreses(UserAddress address) async {
    final response = await service.put(
      path: 'profile/user/address/${address.id}',
      data: address.toJson(),
    );
    if (response.hasError) {
      throw response.error;
    }
    return UserAddress.fromJson(
      Map<String, dynamic>.from(response.data!['data']),
    );
  }

  Future<List<UserAddress>> getAddreses(String userId) async {
    final response = await service.get(
      path: 'profile/user/$userId/addresses',
      params: {'PageNumber': 1, 'PageSize': 20},
    );
    if (response.hasError) {
      throw response.error;
    }
    final List addresses = List.from(response.data!['data']);
    return addresses
        .map((ad) => UserAddress.fromJson(Map<String, dynamic>.from(ad)))
        .toList();
  }

  Future<List<CityModel>> fetchCity(int stateId) async {
    final response = await service.get(
      path: 'Location/localgovernments/$stateId',
    );
    if (response.hasError) {
      throw response.error;
    }
    final List addresses = List.from(response.data!['data']);
    return addresses
        .map((ad) => CityModel.fromJson(Map<String, dynamic>.from(ad)))
        .toList();
  }

  Future<List<CountryModel>> fetchCountry() async {
    final response = await service.get(path: 'Location/countries');
    if (response.hasError) {
      throw response.error;
    }
    final List addresses = List.from(response.data!['data']);
    return addresses
        .map((ad) => CountryModel.fromJson(Map<String, dynamic>.from(ad)))
        .toList();
  }

  Future<List<StateModel>> fetchState(int countryId) async {
    final response = await service.get(path: 'Location/states/$countryId');
    if (response.hasError) {
      throw response.error;
    }
    final List addresses = List.from(response.data!['data']);
    return addresses
        .map((ad) => StateModel.fromJson(Map<String, dynamic>.from(ad)))
        .toList();
  }
}
