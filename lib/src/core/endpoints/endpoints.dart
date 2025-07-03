class Endpoints {
  Endpoints._();

  static Uri getAddressByCep(String cep) {
    return Uri.parse('https://viacep.com.br/ws/$cep/json/');
  }
}
