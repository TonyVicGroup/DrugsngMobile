import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/utils/app_data_types.dart';
import 'package:drugs_ng/features/checkout/data/datasources/address_datasource.dart';
import 'package:drugs_ng/features/checkout/data/models/address/user_address.dart';
import 'package:drugs_ng/features/checkout/data/models/state_and_city.dart';

import 'package:either_dart/either.dart';

class AddressRepo {
  final AddressDatasource datasource = AddressDatasource();

  AsyncApiErrorOr<UserAddress> addAddreses({
    required String userId,
    required UserAddress address,
  }) async {
    try {
      final result = await datasource.addAddreses(
        address: address,
        userId: userId,
      );
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<void> deleteAddress(UserAddress address) async {
    try {
      final result = await datasource.deleteAddress(address);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<UserAddress> editAddreses(UserAddress address) async {
    try {
      final result = await datasource.editAddreses(address);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<UserAddress>> getAddreses(String userId) async {
    try {
      final result = await datasource.getAddreses(userId);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<CityModel>> fetchCity(int stateId) async {
    try {
      final result = await datasource.fetchCity(stateId);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<CountryModel>> fetchCountry() async {
    try {
      final result = await datasource.fetchCountry();
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<StateModel>> fetchState(int countryId) async {
    try {
      final result = await datasource.fetchState(countryId);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }
}
