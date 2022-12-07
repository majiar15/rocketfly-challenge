// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';

class SearchPokemon extends StatefulWidget {
  const SearchPokemon({super.key});

  @override
  State<SearchPokemon> createState() => _SearchPokemonState();
}

class _SearchPokemonState extends State<SearchPokemon> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controlador = TextEditingController();
    final screenSize = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
            width: screenSize.width * 0.68,
            height: 50,
            child: TextField(
              controller: controlador,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xfffe1e1e1), width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide:
                        BorderSide(width: 3, color: Color(0xfffe1e1e1))),                
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide:
                        BorderSide(width: 0, color: Color(0xfffe1e1e1))),
                hintText: 'Buscar un Pokemon',
              ),
            )),
        SizedBox.fromSize(
          size: Size(screenSize.width * 0.02, 20),
        ),
        SizedBox(
          width: screenSize.width * 0.22,
          height: 50,
          child: TextButton(
            onPressed: () => {},
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(color: Colors.red)))),
            child: const Text(
              "BUSCAR",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        )
      ],
    );
  }
}
