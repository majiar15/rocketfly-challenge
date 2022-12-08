// To parse this JSON data, do
//
//     final listPokemon = listPokemonFromJson(jsonString);

import 'dart:convert';

ListPokemon listPokemonFromJson(String str) =>
    ListPokemon.fromJson(json.decode(str));

String listPokemonToJson(ListPokemon data) => json.encode(data.toJson());

class ListPokemon {
  ListPokemon({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  int count;
  String? next;
  String? previous;
  List<Result> results;

  factory ListPokemon.fromJson(Map<String, dynamic> json) {
    final data = ListPokemon(
      count: json["count"],
      next: json["next"] ?? 'default',
      previous: json["previous"] ?? 'default',
      results:
          List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    
    return data;
  }

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
