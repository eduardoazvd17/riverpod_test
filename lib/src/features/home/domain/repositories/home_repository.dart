import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zip_code_search/src/core/errors/failure.dart';
import 'package:zip_code_search/src/features/home/data/datasources/home_datasource.dart';
import 'package:zip_code_search/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:zip_code_search/src/features/home/domain/entities/address_entity.dart';

final homeRepositoryProvider = Provider.autoDispose<IHomeRepository>((ref) {
  return HomeRepositoryImpl(datasource: ref.read(homeDatasourceProvider));
});

abstract class IHomeRepository {
  Future<Either<Failure, AddressEntity>> getAddressByCep(String cep);
}
