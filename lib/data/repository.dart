import 'package:personal_area_app/data/network/models/pokemon_model.dart';
import 'package:personal_area_app/data/network/server_api.dart';

class Repository {
  final _serverApi = ServerApi();

  Future<PokemonList> getPokemons() async {
    final response = await _serverApi.getPokemons();
    return response;
  }
}
