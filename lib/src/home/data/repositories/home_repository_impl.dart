import 'package:riverpod_test/src/home/data/datasources/home_datasource.dart';
import 'package:riverpod_test/src/home/domain/entities/address_entity.dart';
import 'package:riverpod_test/src/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements IHomeRepository {
  final IHomeDatasource datasource;
  HomeRepositoryImpl({required this.datasource});

  @override
  Future<AddressEntity?> getAddressByCep(String cep) async {
    try {
      return await datasource.getAddressByCep(cep);
    } catch (_) {
      return null;
    }
  }
}
