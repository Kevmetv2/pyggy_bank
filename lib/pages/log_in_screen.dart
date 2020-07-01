import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pyggybank/pages/home_screen.dart';
import 'package:pyggybank/pages/sign_up_screen.dart';
import 'package:pyggybank/services/constants.dart';
import 'package:pyggybank/services/repository.dart';
import 'package:pyggybank/widgets/progress.dart';
import 'package:toast/toast.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  var _repository = Repository();
  final _formKey2 = GlobalKey<FormState>();
  String _email, _password;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    void authenticateUser(FirebaseUser user) {
      print("Inside Login Screen -> authenticateUser");
      _repository.authenticateUser(user).then((value) {
        if (value) {
          print("VALUE : $value");
          print("INSIDE IF");
          _repository.addDataToDb(user).then((value) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return HomeScreen();
            }));
          });
        } else {
          print("INSIDE ELSE");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }));
        }
      });
    }

    googleSignIn() {
      _repository.signIn().then((user) {
        setState(() {
          isLoading = false;
        });
        if (user != null) {
          authenticateUser(user);
        } else {
          print("Error");
        }
      });
    }

    emailSignIn() {
      _repository.signInEmail(_email, _password).then((user) {
        setState(() {
          isLoading = false;
        });
        if (user != null) {
          authenticateUser(user);
        } else {
          print("Error");
          Toast.show("Password or Username Incorrect", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          setState(() {
            isLoading = true;
          });
        }
      });
    }

    Widget _buildForgotPasswordBtn() {
      return Container(
        alignment: Alignment.centerRight,
        child: FlatButton(
          onPressed: () => print('Forgot Password Button Pressed'),
          padding: EdgeInsets.only(right: 0.0),
          child: Text(
            'Forgot Password?',
            style: kLabelStyle,
          ),
        ),
      );
    }

    Widget _buildLoginBtn() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () => emailSignIn(),
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.white,
          child: Text(
            'LOGIN',
            style: TextStyle(
              color: Color(0xFF527DAA),
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      );
    }

    Widget _buildSignInWithText() {
      return Column(
        children: <Widget>[
          Text(
            '- OR -',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Sign in with',
            style: kLabelStyle,
          ),
        ],
      );
    }

    Widget _buildSocialBtn(Function onTap, AssetImage logo) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              ),
            ],
            image: DecorationImage(
              image: logo,
            ),
          ),
        ),
      );
    }

    Widget _buildSocialBtnRow() {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildSocialBtn(
              () => print('Login with Facebook'),
              AssetImage(
                'assets/images/facebook.jpg',
              ),
            ),
            _buildSocialBtn(
              () => googleSignIn(),
              AssetImage(
                'assets/images/google.jpg',
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildSignupBtn() {
      return GestureDetector(
        onTap: () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignUpScreen())),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Don\'t have an Account? ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return isLoading
        ? Scaffold(
            body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            //Color(0xFF6930c3),
//                            Color(0xFFa23e48),
//                            Color(0xFFfe7f2d),
                            Color(0xFFE59938),
                            //Color(0xFF657883),

//                            Color(0xFF72efdd),
                          ],
                          stops: [0.3],
                        ),
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.0,
                          vertical: 120.0,
                        ),
                        child: Form(
                          key: _formKey2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset(
                                'assets/images/Pyggybank centered pig and words.svg',
                                height: 160,
                              ),
                              SizedBox(height: 40),
                              Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Email',
                                    style: kLabelStyle,
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    decoration: kBoxDecorationStyle,
                                    height: 60.0,
                                    child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (input) => !input.contains('@')
                                          ? 'Please enter a valid email'
                                          : null,
                                      onChanged: (input) => _email = input,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'OpenSans',
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.only(top: 14.0),
                                        prefixIcon: Icon(
                                          Icons.email,
                                          color: Colors.white,
                                        ),
                                        hintText: 'Enter your Email',
                                        hintStyle: kHintTextStyle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Password',
                                    style: kLabelStyle,
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    decoration: kBoxDecorationStyle,
                                    height: 60.0,
                                    child: TextFormField(
                                      obscureText: true,
                                      validator: (input) => input.length < 6
                                          ? 'Must be at least 6 characters'
                                          : null,
                                      onChanged: (input) => _password = input,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'OpenSans',
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.only(top: 14.0),
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Colors.white,
                                        ),
                                        hintText: 'Enter your Password',
                                        hintStyle: kHintTextStyle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              _buildForgotPasswordBtn(),
                              _buildLoginBtn(),
                              _buildSignInWithText(),
                              _buildSocialBtnRow(),
                              _buildSignupBtn(),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : circularProgress();
  }
}
