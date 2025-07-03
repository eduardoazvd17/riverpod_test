import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/src/core/endpoints/endpoints.dart';
import 'package:riverpod_test/src/home/data/models/address_model.dart';
import 'package:riverpod_test/src/home/domain/entities/address_entity.dart';
import 'package:http/http.dart' as http;

final homeDatasourceProvider = Provider.autoDispose<IHomeDatasource>((ref) {
  return HomeDatasourceImpl(httpClient: http.Client());
});

abstract class IHomeDatasource {
  Future<AddressEntity> getAddressByCep(String cep);
}

class HomeDatasourceImpl implements IHomeDatasource {
  final http.Client httpClient;
  HomeDatasourceImpl({required this.httpClient});

  @override
  Future<AddressEntity> getAddressByCep(String cep) async {
    final response = await httpClient.get(Endpoints.getAddressByCep(cep));
    if (response.statusCode == 200) {
      return AddressModel.fromMap(jsonDecode(response.body));
    }
    throw Exception('Failed to load address: ${response.statusCode}');
  }
}
