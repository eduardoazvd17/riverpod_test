import 'package:dartz/dartz.dart';
import 'package:zip_code_search/src/core/errors/failure.dart';
import 'package:zip_code_search/src/features/home/data/datasources/home_datasource.dart';
import 'package:zip_code_search/src/features/home/domain/entities/address_entity.dart';
import 'package:zip_code_search/src/features/home/domain/repositories/home_repository.dart';

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
