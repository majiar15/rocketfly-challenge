import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rocketflychalenger/src/bloc/detailPokemon/detail_pokemon_bloc.dart';
import 'package:rocketflychalenger/src/bloc/favoritePokemon/favorite_pokemon_bloc.dart';
import 'package:rocketflychalenger/src/bloc/searchPokemon/search_pokemon_bloc.dart';
import 'package:rocketflychalenger/src/models/detail_pokemon.dart';
import 'package:rocketflychalenger/src/util/number_to_string.dart';

class CardPokemon extends StatelessWidget {
  final DetailPokemon pokemonDetail;
  const CardPokemon({super.key, required this.pokemonDetail});

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
    final detailPokemonBloc = BlocProvider.of<DetailPokemonBloc>(context);
    final favoritePokemonBloc = BlocProvider.of<FavoritePokemonBloc>(context);
    final searchPokemonBloc = BlocProvider.of<SearchPokemonBloc>(context);
    return InkWell(
      onTap: () {
        detailPokemonBloc.add(GetDetailEvent(pokemonDetail.id));
        
        Navigator.pushNamed(context, '/detail', arguments: pokemonDetail);
      },
      child: Container(
        height: 150,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: screenSize.width * 0.40,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Hero(
                        tag: pokemonDetail.name,
                        child: FadeInImage(
                          image: NetworkImage(pokemonDetail
                              .sprites!.other!.officialArtwork.frontDefault),
                          placeholder: const AssetImage('assets/no-image.gif'),
                          height: 140.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 120,
                      child: IconButton(
                          onPressed: () {
                            favoritePokemonBloc
                                .add(AddFavoriteEvent(pokemonDetail));
                            searchPokemonBloc
                                .add(MarkHeartRedEvent(pokemonDetail.id));
                          },
                          icon: pokemonDetail.favorite
                              ? SvgPicture.asset(
                                  'assets/heart-filled.svg',
                                  semanticsLabel: 'heart',
                                  color: Colors.red,
                                  width: 100,
                                )
                              : SvgPicture.asset(
                                  'assets/heart.svg',
                                  semanticsLabel: 'heart',
                                  width: 100,
                                )),
                    ),
                  ],
                ),
              ),
              Text(numberToStringZero(pokemonDetail.id)),
              SizedBox.fromSize(
                size: const Size(1, 6),
              ),
              Text(
                pokemonDetail.name,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox.fromSize(
                size: const Size(1, 6),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 229, 231, 235),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Text(
                      pokemonDetail.types[0].type.name.toString(),
                    ),
                  ),
                  SizedBox.fromSize(
                    size: Size(screenSize.width * 0.02, 20),
                  ),
                  // ignore: unnecessary_null_comparison
                  pokemonDetail.types.length > 1
                      ? Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 229, 231, 235),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child:
                              Text(pokemonDetail.types[1].type.name.toString()),
                        )
                      : Container()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
