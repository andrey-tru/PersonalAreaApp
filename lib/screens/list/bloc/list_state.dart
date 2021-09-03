part of 'list_bloc.dart';

abstract class ListState extends Equatable {
  const ListState();

  @override
  List<Object> get props => [];
}

class ListInitial extends ListState {}

class ListLoadInProgress extends ListState {}

class ListLoadSuccess extends ListState {
  final List<Result>? pokemonList;

  const ListLoadSuccess({required this.pokemonList});
}

class ListLoadFail extends ListState {}