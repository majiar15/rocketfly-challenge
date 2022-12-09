part of 'favorite_pokemon_bloc.dart';

@immutable
abstract class FavoritePokemonEvent {}

class FavoriteInitial extends FavoritePokemonEvent {
  FavoriteInitial();
}

class AddFavoriteEvent extends FavoritePokemonEvent {
  final DetailPokemon newPokemonDetail;

  AddFavoriteEvent(this.newPokemonDetail);
}

class GetNumberFavoritesEvent extends FavoritePokemonEvent {
  GetNumberFavoritesEvent();
}

class GetFavoritesPokemonEvent extends FavoritePokemonEvent {
  GetFavoritesPokemonEvent();
}
