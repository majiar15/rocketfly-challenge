part of 'detail_pokemon_bloc.dart';

@immutable
abstract class DetailPokemonState {
   final String? pokemonDescription;
  const DetailPokemonState({
    this.pokemonDescription,
  });
}

class DetailPokemonInitial extends DetailPokemonState {}

class PokemonDescriptionStatus extends DetailPokemonState {
  final String pokemonDesc;

  const PokemonDescriptionStatus(this.pokemonDesc): super(pokemonDescription: pokemonDesc);
}

class DescriptionSuccess extends DetailPokemonState {
    final String pokemonDesc;

  const DescriptionSuccess(this.pokemonDesc): super(pokemonDescription: pokemonDesc);
}
class LoadingDetailPokemonState extends DetailPokemonState {

  const LoadingDetailPokemonState():super ( pokemonDescription: null);
}