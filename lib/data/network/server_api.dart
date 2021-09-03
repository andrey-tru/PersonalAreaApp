import 'package:dio/dio.dart';
import 'package:personal_area_app/data/network/models/pokemon_model.dart';

class ServerApi {
  Future<PokemonList> getPokemons() async {
    Response<String> response = await Dio().get(
      "https://pokeapi.co/api/v2/ability/?limit=327",
    );
    return pokemonListFromJson(response.toString());
  }
}
