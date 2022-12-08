// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rocketflychalenger/src/bloc/searchPokemon/search_pokemon_bloc.dart';
import 'package:rocketflychalenger/src/pages/home/widget/card_pokemon.dart';
import 'package:rocketflychalenger/src/pages/home/widget/card_pokemon_shrimme.dart';
import 'package:rocketflychalenger/src/widgets/circle_notificacion.dart';
import 'package:rocketflychalenger/src/pages/home/widget/search_pokemon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchPokemonBloc = BlocProvider.of<SearchPokemonBloc>(context);
    listenerScroll(context, searchPokemonBloc);

    return Scaffold(
        appBar: AppBar(
          title: SvgPicture.asset('assets/logo.svg', semanticsLabel: 'Logo'),
          backgroundColor: Colors.white,
          actions: [
            Stack(
              children: [
                IconButton(
                    onPressed: () => {},
                    icon: SvgPicture.asset(
                      'assets/heart-filled.svg',
                      semanticsLabel: 'Logo',
                      width: 100,
                    )),
                const Positioned(
                  bottom: 20,
                  left: 12,
                  child: CircleNotification(),
                ),
              ],
            ),
            SizedBox.fromSize(
              size: const Size(15, 10),
            )
          ],
        ),
        backgroundColor: const Color.fromARGB(243, 243, 244, 246),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Pokemones",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox.fromSize(
                  size: const Size(0, 20),
                ),
                const SearchPokemonWidget(),
                SizedBox.fromSize(
                  size: const Size(0, 20),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: const [
                //     CardPokemon(),
                //     CardPokemon(),
                //   ],
                // ),
                // SizedBox.fromSize(
                //   size: const Size(0, 20),
                // ),
                BlocBuilder<SearchPokemonBloc, SearchPokemonState>(
                    builder: ((context, state) {
                  return state is LoadingGeneralPokemonState
                      ? loadingGeneralPokemon()
                      : gridCardPokemon(state);
                }))
                // Scrollbar(

                //   child: FutureBuilder(
                //       future: pokeProvider.getPokemonList(),
                //       builder: (BuildContext context,
                //           AsyncSnapshot<ListPokemon> snapshot) {
                //         if (snapshot.connectionState == ConnectionState.done) {
                //           return snapshot.data != null
                //               ? ListView.builder(
                //                   physics: const NeverScrollableScrollPhysics(),
                //                   shrinkWrap: true,
                //                   itemCount: snapshot.data!.results.length,
                //                   itemBuilder: (BuildContext context, int index){
                //                     return Text(snapshot.data!.results[index].name);
                //                   },
                //                 )
                //               : const Text("Not Data");
                //         } else {
                //           return const Text("Loadding...");
                //         }
                //       }),
                // )
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: const[
                //     CardPokemon(),
                //     CardPokemon(),

                //   ],
                // ),
              ],
            ),
          ),
        ));
  }

  Widget gridCardPokemon(SearchPokemonState state) {
    
    if(state.resultPokemon.isEmpty){
      return const Text("No se encontro el pokemon buscado");
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
          itemCount: state.resultPokemon.length,
          itemBuilder: (BuildContext context, int index) {
            return CardPokemon(
              pokemonDetail: state.resultPokemon[index],
            );
          },
        ),
        state is LoadingPokemonState
            ? const CircularProgressIndicator()
            : const SizedBox()
      ],
    );
  }

  listenerScroll(BuildContext context, SearchPokemonBloc searchPokemonBloc) {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        log("Sigueiente pagiancion");

        searchPokemonBloc
            .add(PaginatedPokemonEvent(searchPokemonBloc.offset + 12));
      }
    });
  }

  Widget loadingGeneralPokemon() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 20.0,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisExtent: 250.0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 12,
      itemBuilder: (BuildContext context, int index) {
        return const CardPokemonShrimme();
      },
    );
  }
}
