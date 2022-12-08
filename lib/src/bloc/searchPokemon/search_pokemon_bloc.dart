// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rocketflychalenger/src/models/detail_pokemon.dart';
import 'package:rocketflychalenger/src/providers/pokemon_provider.dart';

part 'search_pokemon_event.dart';
part 'search_pokemon_state.dart';

class SearchPokemonBloc extends Bloc<SearchPokemonEvent, SearchPokemonState> {
  final pokemonProvider = PokemonProvider();
  List<DetailPokemon> pokemonDetailList = [];
  int offset = 0;

  SearchPokemonBloc() : super(const SearchPokemonInitial()) {
    on<PokemonInitial>((event, emit) async {
      emit(const LoadingGeneralPokemonState());

      final respose = await pokemonProvider.getPokemonList(offset.toString());

      for (var element in respose.results) {
        final pokemonDetail =
            await pokemonProvider.getPokemonDetail(element.url);
        pokemonDetailList.add(pokemonDetail);
      }
      emit(SearchSuccess(pokemonDetailList));
    });

    on<SearchPokemon>((event, emit) async {
      log("entroe al evento");

      emit(const LoadingGeneralPokemonState());

      final response = await pokemonProvider.searchPokemon(event.searchValue);
      if(response != null){
        emit(SearchSuccess([response]));
      }else{
        emit(const SearchSuccess([]));
      }
    });
    on<ReloadPokemonEvent>((event, emit) {
      
      emit(SearchSuccess(pokemonDetailList));
    });

    on<PaginatedPokemonEvent>((event, emit) async {
      // aumentar offset
      emit(LoadingPokemonState(pokemonDetailList));
      offset += event.offset;

      final respose = await pokemonProvider.getPokemonList(offset.toString());

      for (var element in respose.results) {
        final pokemonDetail =
            await pokemonProvider.getPokemonDetail(element.url);
        pokemonDetailList.add(pokemonDetail);
      }

      emit(SearchSuccess(pokemonDetailList));

      //log(event.searchValue.toString());
    });
  }
}
