part of 'detail_pokemon_bloc.dart';

@immutable
abstract class DetailPokemonEvent {}

class GetDetailEvent extends DetailPokemonEvent {
  final int id;
  GetDetailEvent(this.id);
}