

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PokemonFavoritesSQL {
  final int? id;
  final String? pokemon;
  final int? pokemonId;

  PokemonFavoritesSQL(
      {this.id, this.pokemon, this.pokemonId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pokemon': pokemon,
      'pokemonId': pokemonId,
    };
  }
}

Future<Database> openDb() async {
  final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'pokemon.db'), onCreate: (db, version) {
    // Ejecuta la sentencia CREATE TABLE en la base de datos
    return db.execute(
      "CREATE TABLE pokemonFavorite(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, pokemon TEXT, pokemonId INTEGER)",
    );
  }, version: 1);
  return database;
}

Future<void> insertPokemon(PokemonFavoritesSQL pokemonSQL) async {
  final Database db = await openDb();

  await db.insert(
    'pokemonFavorite',
    pokemonSQL.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<PokemonFavoritesSQL>> getAllPokemonsFavorite() async {
  final Database db = await openDb();

  final List<Map<String, dynamic>> maps = await db.query('pokemonFavorite');

  return List.generate(maps.length, (i) {
    return PokemonFavoritesSQL(
      id: maps[i]['id'],
      pokemon: maps[i]['pokemon'],
      pokemonId: maps[i]['pokemonId'],
    );
  });
}
Future<List<PokemonFavoritesSQL>> getAllPokemonsHome() async {
  final Database db = await openDb();

  final List<Map<String, dynamic>> maps = await db.query('pokemonFavorite', columns: ['id', 'pokemonId']);
  

  return List.generate(maps.length, (i) {
    return PokemonFavoritesSQL(
      id: maps[i]['id'],
      pokemonId: maps[i]['pokemonId'],
    );
  });
}

Future<List<PokemonFavoritesSQL>> getByIdPokemonsFavorite(int id) async {
  final Database db = await openDb();

  final List<Map<String, dynamic>> maps = await db.query('pokemonFavorite',
      where: '"pokemonId" = ?', whereArgs: [id.toString()], limit: 1);

  return List.generate(maps.length, (i) {
    return PokemonFavoritesSQL(
      id: maps[i]['id'],
      pokemon: maps[i]['pokemon'],
      pokemonId: maps[i]['pokemonId'],
    );
  });
}

Future<void> deletePokemon(int id) async {
  // Get a reference to the database.
  final db = await openDb();

  // Remove the Dog from the database.
  await db.delete(
    'pokemonFavorite',
    // Use a `where` clause to delete a specific dog.
    where: 'id = ?',
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [id],
  );
}
