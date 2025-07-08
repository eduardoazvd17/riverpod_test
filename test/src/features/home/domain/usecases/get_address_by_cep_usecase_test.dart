import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_test/src/core/errors/failure.dart';
import 'package:riverpod_test/src/features/home/domain/entities/address_entity.dart';
import 'package:riverpod_test/src/features/home/domain/repositories/home_repository.dart';
import 'package:riverpod_test/src/features/home/domain/usecases/get_address_by_cep_usecase.dart';

class MockHomeRepository extends Mock implements IHomeRepository {}

void main() {
  late IHomeRepository repository;
  late IGetAddressByCepUsecase usecase;

  setUp(() {
    repository = MockHomeRepository();
    usecase = GetAddressByCepUsecase(repository: repository);
  });

  group('HomeRepository Tests', () {
    test(
      'should return a valid address when the response is successful',
      () async {
        //Arrange
        when(() => repository.getAddressByCep(any())).thenAnswer((_) async {
          return Right(_mockAddress);
        });

        //Act
        final result = await usecase('12345-678');

        //Assert
        expect(result.isRight(), true);
      },
    );

    test(
      'should return a failure when the response is not successful',
      () async {
        //Arrange
        when(() => repository.getAddressByCep(any())).thenAnswer((_) async {
          return Left(Failure(message: 'message'));
        });

        //Act
        final result = await usecase('12345-678');

        //Assert
        expect(result.isLeft(), true);
      },
    );
  });
}

final _mockAddress = AddressEntity(
  cep: '12345-678',
  address: 'Testing Street',
  neighborhood: 'Testing',
  city: 'Rio de Janeiro',
  state: 'RJ',
);
