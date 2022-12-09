  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rocketflychalenger/src/bloc/favoritePokemon/favorite_pokemon_bloc.dart';
import 'package:rocketflychalenger/src/pages/favorites/favorites_page.dart';
import 'package:rocketflychalenger/src/widgets/circle_notificacion.dart';

AppBar appbarMethod(BuildContext context, bool isFavoritePage) {
    final favoritePokemonBloc = BlocProvider.of<FavoritePokemonBloc>(context);

    return AppBar(
        title: SvgPicture.asset('assets/logo.svg', semanticsLabel: 'Logo'),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          Stack(
            children: [
              IconButton(
                  onPressed: () {
                    if(isFavoritePage){
                      favoritePokemonBloc.add(GetFavoritesPokemonEvent());
                      Navigator.push(context,    MaterialPageRoute(builder: (context) => const FavoritePage()));
                    }
                  },
                  icon: SvgPicture.asset(
                    'assets/heart-filled.svg',
                    semanticsLabel: 'Logo',
                    width: 100,
                  )),
              const Positioned(
                bottom: 33,
                left: 25,
                child: CircleNotification(),
              ),
            ],
          ),
          SizedBox.fromSize(
            size: const Size(15, 10),
          )
        ],
      );
  }
