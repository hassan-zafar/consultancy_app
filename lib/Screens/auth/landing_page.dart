// ignore_for_file: deprecated_member_use
import 'package:consultancy_app/Screens/auth/sign_up.dart';
import 'package:consultancy_app/Services/global_method.dart';
import 'package:consultancy_app/consts/colors.dart';
import 'package:consultancy_app/database/database.dart';
import 'package:consultancy_app/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../Services/authentication_service.dart';
import 'login.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  List<String> images = [
    'https://resize.prod.femina.ladmedia.fr/rblr/652,438/img/var/2020-03/exercice-de-meditation-pleine-conscience.jpg',
    'https://www.lifestylia.com/wp-content/uploads/2019/11/meditation-696x392.jpg',
    'https://cdn.radiofrance.fr/s3/cruiser-production/2019/06/6224b0db-fcf2-45ec-8746-3d64ef796ea7/1136_gettyimages-578188157.webp',
    'https://resize2.prod.docfr.doc-media.fr/rcrop/650,380,center-middle/img/var/doctissimo/storage/images/fr/www/medecines-douces/meditation/meditation-pleine-conscience/653552-1-fre-FR/meditation-pleine-conscience.jpg',
  ];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalMethods _globalMethods = GlobalMethods();
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    images.shuffle();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
    _animation =
        CurvedAnimation(parent: _animationController!, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController!.reset();
              _animationController!.forward();
            }
          });
    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  void _loginAnonymosly() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final bool _login = await DatabaseMethods().loginAnonymosly();
      if (_login) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainScreens(),));
      } else {
        Navigator.of(context).pop();
      }
      // await _auth.signInAnonymously();
    } catch (error) {
      _globalMethods.authErrorHandle(error.toString(), context);
      print('error occured ${error.toString()}');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      CachedNetworkImage(
        imageUrl: images[1],
        // placeholder: (context, url) => Image.network(
        //   'https://image.flaticon.com/icons/png/128/564/564619.png',
        //   fit: BoxFit.contain,
        // ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: FractionalOffset(_animation!.value, 0),
      ),
      Container(
        margin: EdgeInsets.only(top: 30),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Welcome to Meditation Alive',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: ColorsConsts.backgroundColor),
                      ),
                    )),
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.verified_user_outlined,
                          size: 18,
                        )
                      ],
                    )),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.pink.shade400),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side:
                                BorderSide(color: ColorsConsts.backgroundColor),
                          ),
                        )),
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpScreen.routeName);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sign up',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.person_add_alt,
                          size: 18,
                        )
                      ],
                    )),
              ),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                ),
              ),
              Text(
                'Or continue with',
                style: TextStyle(color: Colors.black),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlineButton(
                onPressed: () async {
                  final bool? _login =
                      await AuthenticationService().signinWithGoogle();
                  if (_login!) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => MainScreens(),
                    ));
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                shape: StadiumBorder(),
                highlightedBorderColor: Colors.red.shade200,
                borderSide: BorderSide(width: 2, color: Colors.red),
                child: Text('Google +'),
              ),
              _isLoading
                  ? CircularProgressIndicator()
                  : OutlineButton(
                      onPressed: () {
                        _loginAnonymosly();
                        // Navigator.pushNamed(context, BottomBarScreen.routeName);
                      },
                      shape: StadiumBorder(),
                      highlightedBorderColor: Colors.deepPurple.shade200,
                      borderSide:
                          BorderSide(width: 2, color: Colors.deepPurple),
                      child: Text('Sign in as a guest'),
                    ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    ]));
  }
}
