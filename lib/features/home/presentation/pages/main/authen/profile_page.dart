import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robo_app/features/home/presentation/blocs/authentication/bloc.dart';
import 'package:robo_app/features/home/presentation/blocs/initial_app/initail_app_bloc.dart';
import 'package:robo_app/features/home/presentation/pages/main/tab_bar.dart';

class ProfilePage extends StatefulWidget {
  final BottomNavigationBloc bloc;

  const ProfilePage({
    Key key,
    @required this.bloc,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: TabBarNavigation(
        bloc: widget.bloc,
        currentIndex: 2,
      ),
      appBar: AppBar(title: Text('Profile')),
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            _logoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _logoutButton() {
    return InkWell(
      onTap: () {
        _authenticationBloc.add(LoggedOut());
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
        ),
        child: Text(
          'Logout',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }


}
