import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rocketflychalenger/src/bloc/detailPokemon/detail_pokemon_bloc.dart';
import 'package:rocketflychalenger/src/bloc/favoritePokemon/favorite_pokemon_bloc.dart';
import 'package:rocketflychalenger/src/bloc/searchPokemon/search_pokemon_bloc.dart';
import 'package:rocketflychalenger/src/models/detail_pokemon.dart';
import 'package:rocketflychalenger/src/pages/detail/widgets/shrime_desciption.dart';
import 'package:rocketflychalenger/src/util/number_to_string.dart';
import 'package:rocketflychalenger/src/widgets/appbar.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final pokemonDetail =
        ModalRoute.of(context)!.settings.arguments as DetailPokemon;
    final favoritePokemonBloc = BlocProvider.of<FavoritePokemonBloc>(context);
    final searchPokemonBloc = BlocProvider.of<SearchPokemonBloc>(context);
    return Scaffold(
        appBar: appbarMethod(context, true),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () => {Navigator.pop(context)},
                  icon: SvgPicture.asset(
                    'assets/arrow-left.svg',
                    semanticsLabel: 'arrowLeft',
                    width: 40,
                  )),
              Center(
                child: Hero(
                  tag: pokemonDetail.name,
                  child: FadeInImage(
                    image: NetworkImage(pokemonDetail
                        .sprites!.other!.officialArtwork.frontDefault!),
                    placeholder: const AssetImage('assets/no-image.gif'),
                    height: screenSize.height * 0.3,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: screenSize.width * 0.9,
                  height: screenSize.height * 0.5,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 40,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          pokemonDetail.name,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 229, 231, 235),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Text(
                              pokemonDetail.types[0].type.name.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox.fromSize(
                            size: Size(screenSize.width * 0.02, 20),
                          ),
                          // ignore: unnecessary_null_comparison
                          pokemonDetail.types.length > 1
                              ? Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 229, 231, 235),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: Text(
                                    pokemonDetail.types[1].type.name.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<DetailPokemonBloc, DetailPokemonState>(
                        builder: (context, state) {
                          if (state is LoadingDetailPokemonState) {
                            return const DescriptionShrimme();
                          }
                          return Text(
                            state.pokemonDescription ?? '',
                            maxLines: 4,
                            style: const TextStyle(
                                fontSize: 16, overflow: TextOverflow.ellipsis),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const Text(
                            "ID:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(numberToStringZero(pokemonDetail.id)),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Altura:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(pokemonDetail.height.toString()),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Peso:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(pokemonDetail.weight.toString()),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                          width: screenSize.width * 0.7,
                          child: ElevatedButton(
                            onPressed: () {
                              favoritePokemonBloc
                                  .add(AddFavoriteEvent(pokemonDetail));
                              searchPokemonBloc
                                  .add(MarkHeartRedEvent(pokemonDetail.id));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.all(10),
                            ),
                            child: Text(
                              pokemonDetail.favorite
                                  ? "REMOVER DE FAVORITOS"
                                  : "AGREGAR A FAVORITOS",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
