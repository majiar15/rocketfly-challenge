import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rocketflychalenger/constants.dart';
import 'package:rocketflychalenger/src/models/detail_pokemon.dart';

import 'package:rocketflychalenger/src/models/list_pokemon.dart';

class PokemonProvider {
  Future<ListPokemon> getPokemonList(String offset) async {
    
    final url = Uri.https(urlBase, '/api/v2/pokemon', {'offset': offset, "limit": "12"});
    final resp = await http.get(url);
    
    final decodedData = json.decode(resp.body);
    
    

    final pokemons = ListPokemon.fromJson(decodedData);
    
    return pokemons;
  }
  
  Future<DetailPokemon> getPokemonDetail(String url) async {
    final uri = Uri.parse(url);
    final resp = await http.get(uri);
    
    final decodedData = json.decode(resp.body);
    

    final pokemon = DetailPokemon.fromJson(decodedData);
    
    return pokemon;
  }
  Future<DetailPokemon?> searchPokemon(String pokemon) async {
    
    final url = Uri.https(urlBase, '/api/v2/pokemon/$pokemon',);
    try {
      final resp = await http.get(url);
      final decodedData = json.decode(resp.body);
      

      final returnPokemon = DetailPokemon.fromJson(decodedData);
      
      return returnPokemon;
      
    } catch (e) {
      return null;
    }
    
  }
}
