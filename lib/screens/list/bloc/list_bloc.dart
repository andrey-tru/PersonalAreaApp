import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personal_area_app/data/network/models/pokemon_model.dart';
import 'package:personal_area_app/data/repository.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  final _repository = Repository();
  ListBloc() : super(ListInitial()) {
    add(ListRequested());
  }

  @override
  Stream<ListState> mapEventToState(
    ListEvent event,
  ) async* {
    if (event is ListRequested) {
      yield ListLoadInProgress();
      try {
        final PokemonList pokemonList = await _repository.getPokemons();
        yield ListLoadSuccess(pokemonList: pokemonList.results);
      } catch (_) {
        yield ListLoadFail();
      }
    }
  }
}
