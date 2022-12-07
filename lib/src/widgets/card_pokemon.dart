import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardPokemon extends StatelessWidget {
  const CardPokemon({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
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
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: FadeInImage(
                      image: NetworkImage(
                          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"),
                      placeholder: AssetImage('assets/no-image.gif'),
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
            const Text("0001"),
            SizedBox.fromSize(
              size: const Size(1, 6),
            ),
            const Text(
              "bulbasaur",
              style: TextStyle(fontWeight: FontWeight.bold),
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
                  child: const Text(
                    "Grass",
                  ),
                ),
                SizedBox.fromSize(
                  size: Size(screenSize.width * 0.02, 20),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 229, 231, 235),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: const Text("Poison"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
