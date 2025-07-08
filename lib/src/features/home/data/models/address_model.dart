import 'package:zip_code_search/src/features/home/domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  AddressModel({
    required super.cep,
    required super.address,
    required super.neighborhood,
    required super.city,
    required super.state,
  });

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      cep: map['cep'],
      address: map['logradouro'],
      neighborhood: map['bairro'],
      city: map['localidade'],
      state: map['estado'],
    );
  }
}
