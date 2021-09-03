import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_area_app/data/network/models/pokemon_model.dart';
import 'package:personal_area_app/screens/list/bloc/list_bloc.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Result>? pokemonListName = [];
    return BlocBuilder<ListBloc, ListState>(
      builder: (context, state) {
        if (state is ListLoadSuccess) {
          pokemonListName = state.pokemonList;
        }
        if (pokemonListName!.isNotEmpty) {
          return Scaffold(
            appBar: AppBar(
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Column(
                  children: [
                    Text(
                      'Количество персонажей: ${pokemonListName!.length}',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
            body: Container(
              child: ListView.builder(
                itemBuilder: (context, i) {
                  return ListTile(
                    onTap: () {
                      print('tap');
                    },
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${pokemonListName![i].name}',
                        ),
                        Divider(),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
