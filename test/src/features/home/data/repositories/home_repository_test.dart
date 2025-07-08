import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_test/src/features/home/data/datasources/home_datasource.dart';
import 'package:riverpod_test/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:riverpod_test/src/features/home/domain/entities/address_entity.dart';
import 'package:riverpod_test/src/features/home/domain/repositories/home_repository.dart';

class MockHomeDatasource extends Mock implements IHomeDatasource {}

void main() {
  late IHomeDatasource datasource;
  late IHomeRepository repository;

  setUp(() {
    datasource = MockHomeDatasource();
    repository = HomeRepositoryImpl(datasource: datasource);
  });

  group('HomeRepository Tests', () {
    test(
      'should return a valid address when the response is successful',
      () async {
        //Arrange
        when(() => datasource.getAddressByCep(any())).thenAnswer((_) async {
          return _mockAddress;
        });

        //Act
        final result = await repository.getAddressByCep('22743-040');

        //Assert
        expect(result.isRight(), true);
      },
    );

    test(
      'should return a failure when the response is not successful',
      () async {
        //Arrange
        when(() => datasource.getAddressByCep(any())).thenThrow(Exception());

        //Act
        final result = await repository.getAddressByCep('22743-040');

        //Assert
        expect(result.isLeft(), true);
      },
    );
  });
}

final _mockAddress = AddressEntity(
  cep: '22743-040',
  address: 'Estrada Capenha',
  neighborhood: 'Pechincha',
  city: 'Rio de Janeiro',
  state: 'RJ',
);
