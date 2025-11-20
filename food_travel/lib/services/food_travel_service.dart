import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';
import '../models/usuario.dart';
import '../models/restaurante.dart';
import '../models/prato.dart';
import '../models/avaliacao.dart';
import '../models/favorito.dart';
import '../models/login_dto.dart';

class FoodTravelService {
  final List<Usuario> _usuarios = [];
  final List<Restaurante> _restaurantes = [];
  final List<Prato> _pratos = [];
  final List<Avaliacao> _avaliacoes = [];
  final List<Favorito> _favoritos = [];

  // ------------------ USUÁRIO ------------------
  void adicionarUsuario(Usuario usuario) {
    _usuarios.add(usuario);
  }

  List<Usuario> listarUsuarios() => List.unmodifiable(_usuarios);

  Usuario? getUsuarioPorId(String id) =>
      _usuarios.firstWhereOrNull((u) => u.id == id);

  Usuario? autenticar(LoginDTO loginDTO) {
    return _usuarios.firstWhereOrNull(
      (u) => u.email == loginDTO.email && u.senha == loginDTO.senha,
    );
  }

  void atualizarUsuario(Usuario usuario) {
    final index = _usuarios.indexWhere((u) => u.id == usuario.id);
    if (index != -1) _usuarios[index] = usuario;
  }

  void removerUsuario(String id) {
    _usuarios.removeWhere((u) => u.id == id);
  }

  // ------------------ RESTAURANTE ------------------
  void adicionarRestaurante(Restaurante r) => _restaurantes.add(r);

  List<Restaurante> listarRestaurantes() => List.unmodifiable(_restaurantes);

  Restaurante? getRestaurantePorId(String id) =>
      _restaurantes.firstWhereOrNull((r) => r.id == id);

  void atualizarRestaurante(Restaurante r) {
    final index = _restaurantes.indexWhere((rest) => rest.id == r.id);
    if (index != -1) _restaurantes[index] = r;
  }

  void removerRestaurante(String id) {
    _restaurantes.removeWhere((r) => r.id == id);
  }

  // ------------------ PRATO ------------------
  void adicionarPrato(Prato p) => _pratos.add(p);

  List<Prato> listarPratos() => List.unmodifiable(_pratos);

  List<Prato> listarPratosPorRestaurante(String restauranteId) =>
      _pratos.where((p) => p.restauranteId == restauranteId).toList();

  Prato? getPratoPorId(String id) => _pratos.firstWhereOrNull((p) => p.id == id);

  void atualizarPrato(Prato p) {
    final index = _pratos.indexWhere((pr) => pr.id == p.id);
    if (index != -1) _pratos[index] = p;
  }

  void removerPrato(String id) {
    _pratos.removeWhere((p) => p.id == id);
  }

  // ------------------ AVALIAÇÃO ------------------
  void adicionarAvaliacao(Avaliacao a) => _avaliacoes.add(a);

  List<Avaliacao> listarAvaliacoesPorPrato(String pratoId) =>
      _avaliacoes.where((a) => a.pratoId == pratoId).toList();

  double calcularMediaAvaliacoes(String pratoId) {
    final avaliacoes = listarAvaliacoesPorPrato(pratoId);
    if (avaliacoes.isEmpty) return 0.0;
    final total = avaliacoes.fold<double>(0, (sum, a) => sum + a.nota);
    return total / avaliacoes.length;
  }

  // ------------------ FAVORITOS ------------------
  void adicionarFavorito(Favorito f) {
    if (!_favoritos.any(
        (fav) => fav.usuarioId == f.usuarioId && fav.pratoId == f.pratoId)) {
      _favoritos.add(f);
    }
  }

  void removerFavorito(String usuarioId, String pratoId) {
    _favoritos.removeWhere(
        (f) => f.usuarioId == usuarioId && f.pratoId == pratoId);
  }

  List<Prato> listarFavoritosDoUsuario(String usuarioId) {
    final idsFavoritos =
        _favoritos.where((f) => f.usuarioId == usuarioId).map((f) => f.pratoId);
    return _pratos.where((p) => idsFavoritos.contains(p.id)).toList();
  }
}
