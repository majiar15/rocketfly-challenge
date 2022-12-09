part of 'favorite_pokemon_bloc.dart';

@immutable
abstract class FavoritePokemonState {

  final List<DetailPokemon> pokemonDetail;
  final int counterFavorite;
  const FavoritePokemonState({
    this.pokemonDetail = const [],
    this.counterFavorite = 0
  });

}

class FavoritePokemonInitial extends FavoritePokemonState {
  const FavoritePokemonInitial(): super();
}

class AddFavoriteStatus extends FavoritePokemonState {
   final List<DetailPokemon> newPokemonDetail;
  const AddFavoriteStatus(this.newPokemonDetail): super(pokemonDetail: newPokemonDetail);
}
class CounterFavoriteStatus extends FavoritePokemonState {
  final List<DetailPokemon> pokemonFavorites;
   final int counterFavorites;
  const CounterFavoriteStatus(this.pokemonFavorites,this.counterFavorites): super(pokemonDetail: pokemonFavorites, counterFavorite: counterFavorites);
}
class PokemonFavoriteStatus extends FavoritePokemonState {
  final List<DetailPokemon> pokemonFavorites;
  final int counterFavorites;

  const PokemonFavoriteStatus(this.pokemonFavorites, this.counterFavorites): super(pokemonDetail: pokemonFavorites, counterFavorite: counterFavorites);
}


