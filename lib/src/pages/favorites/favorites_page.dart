
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rocketflychalenger/src/bloc/favoritePokemon/favorite_pokemon_bloc.dart';
import 'package:rocketflychalenger/src/pages/home/widget/card_pokemon.dart';
import 'package:rocketflychalenger/src/widgets/appbar.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarMethod(context, false),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () => {Navigator.pop(context)},
                          icon: SvgPicture.asset(
                            'assets/arrow-left.svg',
                            semanticsLabel: 'arrowLeft',
                            width: 40,
                          )),
                      const SizedBox(
                        width: 30,
                      ),
                      const Text(
                        "Favoritos",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<FavoritePokemonBloc, FavoritePokemonState>(
                    builder: ((context, state) {
                  return gridCardPokemon(state);
                }))
                // BlocBuilder<SearchPokemonBloc, SearchPokemonState>(
                //     builder: ((context, state) {
                //   return state is LoadingGeneralPokemonState
                //       ? loadingGeneralPokemon()
                //       : gridCardPokemon(state);
                // }))
              ],
            ),
          ),
        ));

    //    Column(
    //     children: [
    //       const SizedBox(
    //         height: 15,
    //       ),

    //     ],
    //   ),
    // );
  }

}

Widget gridCardPokemon(FavoritePokemonState state) {
  
  if (state.pokemonDetail.isEmpty) {
    return const Text("No hay pokemones favoritos :c");
  }
  return Column(
    children: [
      GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 20.0,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisExtent: 250.0),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: state.pokemonDetail.length,
        itemBuilder: (BuildContext context, int index) {
          return CardPokemon(
            pokemonDetail: state.pokemonDetail[index],
          );
        },
      ),
    ],
  );
}
