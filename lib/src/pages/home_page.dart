// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rocketflychalenger/src/widgets/card_pokemon.dart';
import 'package:rocketflychalenger/src/widgets/circle_notificacion.dart';
import 'package:rocketflychalenger/src/widgets/search_pokemon.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
              const SearchPokemon(),
              SizedBox.fromSize(
                size: const Size(0, 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const[
                  CardPokemon(),
                  CardPokemon(),
                  
                ],
              ),
              SizedBox.fromSize(
                size: const Size(0, 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const[
                  CardPokemon(),
                  CardPokemon(),
                  
                ],
              ),
            ],
          ),
        ));
  }
}
