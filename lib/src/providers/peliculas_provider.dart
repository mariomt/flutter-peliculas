import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = '17a1b28662ce64a89fb4ae0e3c205f48';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularesPage = 0;
  bool _loading = false;

  List<Pelicula> _populares = new List();
  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStrams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _responseProcess(Uri url) async {
    final response = await http.get(url);
    final decodeData = json.decode(response.body);
    final peliculas = new Peliculas.fromJsonList(decodeData['results']);
    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apikey, 'language': _language});
    return await _responseProcess(url);
  }

  Future<List<Pelicula>> getPopular() async {
    if (_loading) return [];
    _loading = true;
    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString(),
    });

    final resp = await _responseProcess(url);
    _populares.addAll(resp);
    popularesSink(_populares);
    _loading = false;
    return resp;
  }
}
