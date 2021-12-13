import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:robo_app/features/home/domain/entities/cocktail.dart';
import 'package:robo_app/features/home/presentation/blocs/home/bloc.dart';
import 'package:robo_app/features/home/presentation/blocs/home/home_bloc.dart';
import 'package:robo_app/features/home/presentation/blocs/initial_app/bloc.dart';
import 'package:robo_app/features/home/presentation/pages/main/home/widgets/header.dart';

import '../tab_bar.dart';
import 'widgets/hot_menu.dart';
import 'widgets/menu_group.dart';

class HomePage extends StatefulWidget {
  final BottomNavigationBloc bloc;

  const HomePage({Key key, @required this.bloc}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Cocktail> cocktails;
  HomeBloc homeBloc;
  var bloc;
  @override
  void initState() {
    bloc = widget.bloc;
    homeBloc = BlocProvider.of<HomeBloc>(context);
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Widget build(BuildContext context) {
    final _scrollController = TrackingScrollController();

    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: TabBarNavigation(
          bloc: bloc,
          currentIndex: 0,
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.only(
                  left: 8,
                  top: 40,
                ),
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: <Widget>[
                      MenuGroup(),
                      BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                        if (state is PopularMenuLoading) {
                          return HotMenu(
                            loading: true,
                          );
                        } else if (state is PopularMenuLoaded) {
                          cocktails = state.cocktail;
                          return HotMenu(cocktails: state.cocktail);
                        }
                        return HotMenu(
                          loading: true,
                        );
                      }),
                    ],
                  ),
                ),
              ),
              BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                if (state is PopularMenuLoaded) {
                  return HeaderHome(
                    listCocktail: state.cocktail,
                    scrollController: _scrollController,
                  );
                }
                return HeaderHome(
                  listCocktail: null,
                  scrollController: _scrollController,
                );
              })
            ],
          ),
        ));
  }

  void _onRefresh() async {
    homeBloc..add(GetListPopularCocktail(refresh: true));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }
}
