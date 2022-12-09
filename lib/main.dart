import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rocketflychalenger/src/bloc/detailPokemon/detail_pokemon_bloc.dart';
import 'package:rocketflychalenger/src/bloc/favoritePokemon/favorite_pokemon_bloc.dart';
import 'package:rocketflychalenger/src/bloc/searchPokemon/search_pokemon_bloc.dart';
import 'package:rocketflychalenger/src/pages/detail/detail_page.dart';
import 'package:rocketflychalenger/src/pages/favorites/favorites_page.dart';
import 'package:rocketflychalenger/src/pages/home/home_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            lazy: false,
            create: (_) => SearchPokemonBloc()..add(PokemonInitial())),
        BlocProvider(create: (_) => FavoritePokemonBloc()..add(GetNumberFavoritesEvent())),
        BlocProvider(create: (_) => DetailPokemonBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rocketflychalenger',
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => const HomePage(),
          '/favorite': (BuildContext context) => const FavoritePage(),
          '/detail': (BuildContext context) => const DetailPage(),
        },
      ),
    );
  }
}
