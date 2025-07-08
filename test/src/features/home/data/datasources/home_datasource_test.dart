import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_test/src/features/home/data/datasources/home_datasource.dart';
import 'package:riverpod_test/src/features/home/domain/entities/address_entity.dart';

class MockHttpClient extends Mock implements Client {}

void main() {
  late Client httpClient;
  late IHomeDatasource datasource;

  setUp(() {
    httpClient = MockHttpClient();
    datasource = HomeDatasourceImpl(httpClient: httpClient);
    registerFallbackValue(Uri.parse(''));
  });

  group('HomeDatasource Tests', () {
    test(
      'should return a valid address when the response is successful',
      () async {
        //Arrange
        when(() => httpClient.get(any())).thenAnswer((_) async {
          return Response(_mockResponse, 200);
        });

        //Act
        final result = await datasource.getAddressByCep('22743-040');

        //Expect
        expect(result, isA<AddressEntity>());
      },
    );

    test(
      'should throw an exception when the response is not successful',
      () async {
        //Arrange
        when(() => httpClient.get(any())).thenThrow(Exception());

        //Act
        final result = datasource.getAddressByCep('22743-040');

        //Assert
        expect(result, throwsA(isA<Exception>()));
      },
    );
  });
}

const _mockResponse = '''
{
  "cep": "22743-040",
  "logradouro": "Estrada Capenha",
  "complemento": "até 99998 - lado par",
  "unidade": "",
  "bairro": "Pechincha",
  "localidade": "Rio de Janeiro",
  "uf": "RJ",
  "estado": "Rio de Janeiro",
  "regiao": "Sudeste",
  "ibge": "3304557",
  "gia": "",
  "ddd": "21",
  "siafi": "6001"
}
''';
