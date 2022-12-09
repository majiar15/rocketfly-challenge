
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:rocketflychalenger/src/providers/pokemon_provider.dart';

part 'detail_pokemon_event.dart';
part 'detail_pokemon_state.dart';

class DetailPokemonBloc extends Bloc<DetailPokemonEvent, DetailPokemonState> {
  DetailPokemonBloc() : super(DetailPokemonInitial()) {
  final pokemonProvider = PokemonProvider();

    on<GetDetailEvent>((event, emit) async {
      
      

      emit(const LoadingDetailPokemonState());

      final response = await pokemonProvider.descriptionPokemon(event.id.toString());
      
      if(response != null){
        final  descp = response.flavorTextEntries!.where((resp) => resp.language!.name == 'es').toList();
        emit(DescriptionSuccess(descp[0].flavorText ?? ''));
      }else{
        emit(DetailPokemonInitial());
      }
      
    });



  }
}
