part of 'search_pokemon_bloc.dart';

@immutable
abstract class SearchPokemonEvent {


}

class SearchPokemon extends SearchPokemonEvent {
  final String searchValue;
  SearchPokemon(this.searchValue);
}

class PaginatedPokemonEvent extends SearchPokemonEvent {
  final int offset;
  PaginatedPokemonEvent(this.offset);
}
class ReloadPokemonEvent extends SearchPokemonEvent {
 
  ReloadPokemonEvent();
}

class PokemonInitial extends SearchPokemonEvent {}