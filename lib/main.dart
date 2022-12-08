import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rocketflychalenger/src/bloc/searchPokemon/search_pokemon_bloc.dart';
import 'package:rocketflychalenger/src/pages/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(lazy: false, create: (_) => SearchPokemonBloc()..add(PokemonInitial()))
        ],
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rocketflychalenger',
        initialRoute: '/',
        routes: {
          '/'       : ( BuildContext context ) => const HomePage(),
          
        },
          ),
      );
  }
}
