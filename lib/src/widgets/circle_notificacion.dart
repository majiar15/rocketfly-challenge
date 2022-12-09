import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rocketflychalenger/src/bloc/favoritePokemon/favorite_pokemon_bloc.dart';

class CircleNotification extends StatelessWidget {
  const CircleNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritePokemonBloc, FavoritePokemonState>(
        builder: ((context, state) {
      return Container(
        width: 20,
        height: 20,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
        child: Center(child: Text(state.counterFavorite.toString())),
      );
    }));

 
  }
}
