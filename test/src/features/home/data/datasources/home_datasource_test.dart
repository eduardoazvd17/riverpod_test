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
        final result = await datasource.getAddressByCep('12345-678');

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
        final result = datasource.getAddressByCep('12345-678');

        //Assert
        expect(result, throwsA(isA<Exception>()));
      },
    );
  });
}

const _mockResponse = '''
{
  "cep": "12345-678",
  "logradouro": "Testing Street",
  "complemento": "até 99998 - lado par",
  "unidade": "",
  "bairro": "Testing",
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
