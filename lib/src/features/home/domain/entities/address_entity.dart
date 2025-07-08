class AddressEntity {
  final String cep;
  final String address;
  final String neighborhood;
  final String city;
  final String state;

  AddressEntity({
    required this.cep,
    required this.address,
    required this.neighborhood,
    required this.city,
    required this.state,
  });

  @override
  String toString() {
    return 'CEP: $cep\nAddress: $address\nNeighborhood: $neighborhood\nCity: $city\nState: $state';
  }
}
