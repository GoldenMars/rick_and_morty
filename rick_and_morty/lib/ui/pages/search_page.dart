import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:rick_and_morty/bloc/character_bloc.dart';
import 'package:rick_and_morty/data/models/character.dart';
import 'package:rick_and_morty/ui/widgets/custom_list_tile.dart';

//TODO: добваить поиск по имени

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Character _currentCaracter;
  List<Results> _currentResults = [];
  int _currentPage = 1;

  final RefreshController refreshController = RefreshController();
  bool _isPagination = false;

  @override
  void initState() {
    if (_currentResults.isEmpty) {
      context.read<CharacterBloc>().add(
        const CharacterEvent.fetch(page: 1, name: ''),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CharacterBloc>().state;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: state.when(
            loading: () {
              if (!_isPagination) {
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 10),
                      Text('Loading...'),
                    ],
                  ),
                );
              } else {
                return _customListView(_currentResults);
              }
            },
            loaded: (characterLoaded) {
              _currentCaracter = characterLoaded;
              if (_isPagination) {
                _currentResults.addAll(_currentCaracter.results);
                refreshController.loadComplete();
                _isPagination = false;
              } else {
                _currentResults = _currentCaracter.results;
              }

              return _currentResults.isNotEmpty
                  ? _customListView(_currentResults)
                  : const SizedBox();
            },
            error: () => Text('Nothing found...'),
          ),
        ),
      ],
    );
  }

  Widget _customListView(List<Results> currentResults) {
    return SmartRefresher(
      controller: refreshController,
      enablePullUp: true,
      enablePullDown: false,
      onLoading: () {
        _isPagination = true;
        _currentPage++;
        if (_currentPage <= _currentCaracter.info.pages) {
          context.read<CharacterBloc>().add(
            CharacterEvent.fetch(page: _currentPage, name: ''),
          );
        } else {
          refreshController.loadNoData();
        }
      },
      child: ListView.separated(
        itemBuilder: (context, index) {
          final result = currentResults[index];
          return Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 5,
              bottom: 5,
            ),
            child: CustomListTile(result: result),
          );
        },
        separatorBuilder: (_, index) => const SizedBox(height: 5),
        itemCount: currentResults.length,
        shrinkWrap: true,
      ),
    );
  }
}
