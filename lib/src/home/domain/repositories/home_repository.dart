import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/src/core/errors/failure.dart';
import 'package:riverpod_test/src/home/data/datasources/home_datasource.dart';
import 'package:riverpod_test/src/home/data/repositories/home_repository_impl.dart';
import 'package:riverpod_test/src/home/domain/entities/address_entity.dart';

final homeRepositoryProvider = Provider.autoDispose<IHomeRepository>((ref) {
  return HomeRepositoryImpl(datasource: ref.read(homeDatasourceProvider));
});

abstract class IHomeRepository {
  Future<Either<Failure, AddressEntity>> getAddressByCep(String cep);
}
