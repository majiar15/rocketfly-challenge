// ignore_for_file: depend_on_referenced_packages


import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rocketflychalenger/src/models/detail_pokemon.dart';
import 'package:rocketflychalenger/src/sqlite/pokemon_favorites_sql.dart';
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
      final pokemoFavorite = await getAllPokemonsHome();
      final respose = await pokemonProvider.getPokemonList(offset.toString());

      for (var element in respose.results) {
        DetailPokemon pokemonDetail =
            await pokemonProvider.getPokemonDetail(element.url);

        // ver marcar los pokemones favoritos
        bool exists = pokemoFavorite.any((favorite) => favorite.pokemonId == pokemonDetail.id);
        if(exists) pokemonDetail.favorite = true;
        
        pokemonDetailList.add(pokemonDetail);
      }
      
      emit(SearchSuccess(pokemonDetailList));
    });

    on<SearchPokemon>((event, emit) async {
      

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

      
    });
  
    on<MarkHeartRedEvent>((event, emit) async {
      
      emit(SearchSuccess(pokemonDetailList));

      pokemonDetailList.map((pokemon){
      
        if(event.id == pokemon.id){
      

            pokemon.favorite = !pokemon.favorite;

        }
        return pokemon;
      }).toList();
      emit(MarkHeartRedStatus(pokemonDetailList));
    });
  }
}
