import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rocketflychalenger/src/models/detail_pokemon.dart';

class CardPokemon extends StatelessWidget {
  final DetailPokemon pokemonDetail;
  const CardPokemon({super.key, required this.pokemonDetail});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
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
                    child: FadeInImage(
                      image: NetworkImage(pokemonDetail
                          .sprites!.other!.officialArtwork.frontDefault),
                      placeholder: const AssetImage('assets/no-image.gif'),
                      height: 140.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 120,
                    child: IconButton(
                        onPressed: () => {},
                        icon: SvgPicture.asset(
                          'assets/heart.svg',
                          semanticsLabel: 'Logo',
                          width: 100,
                        )),
                  ),
                ],
              ),
            ),
            Text(pokemonDetail.id.toString()),
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
    );
  }
}
