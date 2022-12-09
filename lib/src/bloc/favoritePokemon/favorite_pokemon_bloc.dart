import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:rocketflychalenger/src/models/detail_pokemon.dart';
import 'package:rocketflychalenger/src/sqlite/pokemon_favorites_sql.dart';

part 'favorite_pokemon_event.dart';
part 'favorite_pokemon_state.dart';

class FavoritePokemonBloc
    extends Bloc<FavoritePokemonEvent, FavoritePokemonState> {
  int favoriteCounter = 0;
  List<DetailPokemon> pokemonsFavorites = [];

  FavoritePokemonBloc() : super(const FavoritePokemonInitial()) {
    on<AddFavoriteEvent>((event, emit) async {
      final List<PokemonFavoritesSQL> queryResult =
          await getByIdPokemonsFavorite(event.newPokemonDetail.id);
      if (queryResult.isEmpty) {
        log("insertando pokemon en base de datos...");
        final favorite = PokemonFavoritesSQL(
            id: null,
            pokemon: detailPokemonToJson(event.newPokemonDetail),
            pokemonId: event.newPokemonDetail.id);
        favoriteCounter++;
        await insertPokemon(favorite);
      } else {
        log("Eliminando pokemon en base de datos...");
        favoriteCounter--;
        pokemonsFavorites.removeWhere((pokemon) => pokemon.id == event.newPokemonDetail.id);
        await deletePokemon(queryResult[0].id!);
      }
      emit(CounterFavoriteStatus(pokemonsFavorites, favoriteCounter));
    });

    on<GetNumberFavoritesEvent>((event, emit) async {
      final pokemoFavorite = await getAllPokemonsHome();
      log(pokemoFavorite.length.toString());
      favoriteCounter = pokemoFavorite.length;
      emit(CounterFavoriteStatus(pokemonsFavorites,favoriteCounter));
    });

    on<GetFavoritesPokemonEvent>((event, emit) async {
      final pokemoFavoriteSQL = await getAllPokemonsFavorite();

      for (var pokemonSQL in pokemoFavoriteSQL) {
        DetailPokemon pokemonDetail =
            detailPokemonFromJson(pokemonSQL.pokemon!);
        pokemonDetail.favorite = true;
        bool exists = pokemonsFavorites
            .any((favorite) => favorite.id == pokemonDetail.id);
        if (!exists) {
          pokemonsFavorites.add(pokemonDetail);
        }
        log(pokemonsFavorites.toString());
      }

      emit(PokemonFavoriteStatus(pokemonsFavorites,favoriteCounter));
    });
  }
}
