import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/src/core/errors/failure.dart';
import 'package:riverpod_test/src/home/domain/entities/address_entity.dart';
import 'package:riverpod_test/src/home/domain/repositories/home_repository.dart';

final getAddressByCepUsecaseProvider =
    Provider.autoDispose<IGetAddressByCepUsecase>((ref) {
      return GetAddressByCepUsecase(
        repository: ref.read(homeRepositoryProvider),
      );
    });

abstract class IGetAddressByCepUsecase {
  Future<Either<Failure, AddressEntity>> call(String cep);
}

class GetAddressByCepUsecase implements IGetAddressByCepUsecase {
  final IHomeRepository repository;
  GetAddressByCepUsecase({required this.repository});

  @override
  Future<Either<Failure, AddressEntity>> call(String cep) async {
    return await repository.getAddressByCep(cep);
  }
}
