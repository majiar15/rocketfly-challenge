part of 'search_pokemon_bloc.dart';

@immutable
abstract class SearchPokemonState {

  
  final List<DetailPokemon> resultPokemon;

  const SearchPokemonState({
    this.resultPokemon=const [],
  });


}

class SearchPokemonInitial extends SearchPokemonState {

  const SearchPokemonInitial(): super(  resultPokemon: const []);

}

class SearchSuccess extends SearchPokemonState {
  final List<DetailPokemon> pokemonDetail;
  const SearchSuccess(this.pokemonDetail):super ( resultPokemon: pokemonDetail);
}
class PaginatedPokemonState extends SearchPokemonState {
  final int offset;
  final List<DetailPokemon> pokemonDetail;

  const PaginatedPokemonState(this.offset,this.pokemonDetail):super ( resultPokemon: pokemonDetail);
}

class LoadingPokemonState extends SearchPokemonState {
  final List<DetailPokemon> pokemonDetail;
  const LoadingPokemonState(this.pokemonDetail):super ( resultPokemon: pokemonDetail);
}

class LoadingGeneralPokemonState extends SearchPokemonState {
  const LoadingGeneralPokemonState():super ( resultPokemon: const []);
}

class MarkHeartRedStatus extends SearchPokemonState {
  final List<DetailPokemon> pokemonDetail;
  const MarkHeartRedStatus(this.pokemonDetail):super ( resultPokemon: pokemonDetail);
}