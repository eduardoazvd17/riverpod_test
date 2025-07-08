import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zip_code_search/src/core/errors/failure.dart';
import 'package:zip_code_search/src/features/home/domain/entities/address_entity.dart';
import 'package:zip_code_search/src/features/home/domain/repositories/home_repository.dart';

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
