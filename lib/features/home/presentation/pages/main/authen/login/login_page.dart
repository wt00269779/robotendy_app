import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robo_app/features/home/presentation/blocs/initial_app/initail_app_bloc.dart';
import 'package:robo_app/features/home/presentation/blocs/login/login_bloc.dart';
import 'package:robo_app/features/home/presentation/pages/main/authen/register/register_page.dart';
import 'package:robo_app/features/home/presentation/widgets/loading_indicator.dart';

import '../../tab_bar.dart';

class LoginPage extends StatefulWidget {
  final BottomNavigationBloc bloc;
  final LoginBloc loginBloc;

  const LoginPage({
    Key key,
    @required this.bloc,
    @required this.loginBloc,
  }) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = widget.loginBloc;
    print("LOGIN " + _loginBloc.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: TabBarNavigation(
        bloc: widget.bloc,
        currentIndex: 2,
      ),
      appBar: AppBar(title: Text('Login')),
      body: Container(
        height: height,
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
                backgroundColor: Theme.of(context).errorColor,
              ));
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginLoading) {
                return LoadingIndicator();
              }
              return Stack(
                children: <Widget>[
                  Container(
                    height: 1000,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 50),
                          _title(),
                          SizedBox(height: 50),
                          _emailPasswordWidget(),
                          SizedBox(height: 20),
                          _roboLoginButton(),
                          SizedBox(height: 20),
                          _fbLoginButton(),
                          SizedBox(height: 20),
                          _googleLoginButton(),
                          SizedBox(height: height * .055),
                          _createAccountLabel(),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: isPassword ? passwordController : emailController,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _roboLoginButton() {
    return InkWell(
      onTap: () {
        signIn("Robotendy");
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromRGBO(100, 100, 100, 1),
                  Color.fromRGBO(50, 50, 50, 1)
                ])),
        child: Text(
          'เข้าสู่ระบบ',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _fbLoginButton() {
    return InkWell(
      onTap: () {
        signIn("Facebook");
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blue,
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
          'Login with Facebook',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _googleLoginButton() {
    return InkWell(
      onTap: () {
        signIn("Google");
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
          'Google with Facebook',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegisterPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'คุณมีบัญชีแล้วหรือไม่?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'สมัครสมาชิก',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Robo',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'Tendy',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("ชื่อผู้ใช้งาน"),
        _entryField("รหัสผ่าน", isPassword: true),
      ],
    );
  }

  // Future checkAuth(BuildContext context) async {
  //   if (await userService.hasToken()) {
  //     //Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => ProfilePage(bloc : widget.bloc)));
  //   }
  // }

  void signIn(provider) async {
    var username = emailController.text.trim();
    var password = passwordController.text.trim();
    print("test");

    _loginBloc.add(LoginButtonPressed(
      username: username,
      password: password,
      provider: provider,
      displayName: "",
    ));
  }
}
