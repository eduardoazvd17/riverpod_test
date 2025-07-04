import 'package:dartz/dartz.dart';
import 'package:riverpod_test/src/core/errors/failure.dart';
import 'package:riverpod_test/src/home/data/datasources/home_datasource.dart';
import 'package:riverpod_test/src/home/domain/entities/address_entity.dart';
import 'package:riverpod_test/src/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements IHomeRepository {
  final IHomeDatasource datasource;
  HomeRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, AddressEntity>> getAddressByCep(String cep) async {
    try {
      if (cep.isEmpty) {
        return Left(Failure(message: 'O CEP não pode ser vazio.'));
      }
      if (cep.length != 9) {
        return Left(Failure(message: 'O CEP deve ter 8 dígitos'));
      }
      final address = await datasource.getAddressByCep(cep);
      return Right(address);
    } catch (e) {
      return Left(Failure(message: 'Ocorreu um erro ao buscar o CEP.'));
    }
  }
}
