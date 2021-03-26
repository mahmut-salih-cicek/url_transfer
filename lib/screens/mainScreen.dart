import 'dart:async';

import 'package:clipboard/clipboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:url_transfer/screens/anonimScreen.dart';
import 'package:url_transfer/screens/loginScreen.dart';
import 'package:url_transfer/screens/noteScreen.dart';
import 'package:url_transfer/screens/registerScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:firebase_admob/firebase_admob.dart';


class MainScreen extends StatefulWidget {
  
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
 
int _coins = 0;
  RewardedVideoAd videoAd = RewardedVideoAd.instance;
  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    videoAd.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print("REWARDED VIDEO AD $event");
      if (event == RewardedVideoAdEvent.rewarded) {
        setState(() {
          _coins += rewardAmount;
        });
      }
    };
  }
 
  @override
  Widget build(BuildContext context) {
   ///  banner reklamları kuruluyor ve gösteriliyor
   FirebaseAdMob.instance.initialize(appId: "ca-app-pub-7991360026120390~3210000930").then((response){
     myBanner..load()..show(anchorOffset: 0);
    });


   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 73, 79, 88),
      body: Stack(
        children: <Widget>[
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: BackgroundPaint(),
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: CustomPaint(
                  painter: BackgroundPaint2(),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  )
                  )
                  ),
          
              
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             
            

              Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 16,  //default 60 var 14
                  )),
              Card(
                margin: new EdgeInsets.symmetric(horizontal: 30.0), // default 30
                
                /// kartı içeri dogru ıttırdık !!!
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                shadowColor: Colors.black,
                color:  Color.fromARGB(250, 255, 255, 255),
                elevation: 20,
                //color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 13,//13
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                        
                      child: Column(

                        children: [
                          // Padding(padding: EdgeInsets.symmetric(horizontal:180)),
                          /// birinci textFromField
                          /// 
                           
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                    'Open link on pc with web',
                                    style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),

                          FlatButton(
                            onPressed: () {
                              FlutterClipboard.copy('https://link-from.web.app/');
                            },
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 22),
                                    text: "https://link-from.web.app"),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 00,
                          ),

                          SizedBox(
                            height: 00,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height:  MediaQuery.of(context).size.height / 15,// default 95 // default 10
              ),

              /// Register Buttonu
              Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: SignInButtonBuilder(
                  icon: Icons.person_add,
                  iconColor: Colors.black,
                  elevation: 10,
                  height: 45,

                  ///amber[600]
                  width: 280,
                  backgroundColor: Colors.orange[500],
                  fontSize: 17,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  text: "Register",
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                  },
                ),
              ),

              /// Login button
              Container(
                padding: const EdgeInsets.all(20.0),
                alignment: Alignment.center,
                child: SignInButtonBuilder(
                  elevation: 10,
                  height: 45,
                  width: 280,
                  icon: Icons.login_rounded,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  backgroundColor: Colors.black,
                  text: "Sign In",
                  textColor: Colors.white,
                  fontSize: 15,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                      FirebaseAuth.instance.currentUser == null
                          ? LoginScreen()
                          : NoteScreen(),
                    ));
                  },
                ),
              ),

              /// Login With ANONİM

              Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: SignInButtonBuilder(
                  elevation: 10,
                  height: 45,
                  width: 280,
                  icon: Icons.verified_user,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  backgroundColor: Colors.green.shade700,
                  text: "Qr Login",
                  textColor: Colors.white,
                  fontSize: 15,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                      FirebaseAuth.instance.currentUser == null
                          ? ScanScreen()
                          : NoteScreen(),
                    ));
                  },
                ),
              ),


              ///about me button
              
               Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: SignInButtonBuilder(
                elevation: 15,
                height: 45,
                width: 280,
                icon: Icons.copyright,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                backgroundColor: Colors.deepPurple[500],
                text: "About Me",
                fontSize: 15,
                onPressed: ()  {
                
                _bottomSheetMore(context);

                },
              ),
              ),
      

            ],
          ),
        ],
      ),
    );
  }

 

void _bottomSheetMore(context) {
     videoAd.load(
     adUnitId: RewardedVideoAd.testAdUnitId,    ///RewardedVideoAd.testAdUnitId  ca-app-pub-4377139267165661/4662667498
     targetingInfo: targetingInfo);

  showModalBottomSheet(
    context: context,
    builder: (builder) {
      return new Container(
        padding: EdgeInsets.only(
          left: 15,
          right: 15.0,
          top: 15.0,
          bottom: 15.0,
        ),
        decoration: new BoxDecoration(
          ///shape: RoundedRectangleBorder(
           ///         borderRadius: BorderRadius.circular(15)),
        
            color: Colors.white,
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0))),
        child: new Wrap(
          children: <Widget>[
            new ListTile(
              title: const Text(
                'More',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),


           /// text 1
            new ListTile(
              leading: new Container(
                width: 4.0,
                child: Icon(
                  Icons.favorite,
                  color: Colors.pink,
                  size: 30.0,
                ),
              ),
              title: const Text(
                'Support Me Click And Watch Ad',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onTap: (){
                  videoAd.show();
              },
            ),



            /// text 2
            new ListTile(
              leading: new Container(
                width: 4.0,
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 30.0,
                ),
              ),
              title: const Text(
                'Rating My App',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
                onTap: (){
                launch("https://play.google.com/store/apps/details?id=com.xmod.url.transfer");
                },

     
             /// text 3
            ),
            new ListTile(
              leading: new Container(
                width: 4.0,
                child: Icon(
                  Icons.account_box,
                  color: Colors.blue,
                  size: 30.0,
                ),
              ),

              title: const Text(
                'Visit My Website',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
             onTap: (){
               _launchInBrowser();
             },



            ),
            new Divider(
              height: 80.0,
            ),
            new ListTile(
              title: const Text(
                '',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onTap: () async {
                // Add Here
              },
            ),

          ],
        ),
      );
    },
  );
}
  





}

class BackgroundPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    Path path = Path();
    paint.color = Color.fromARGB(255, 251, 172, 71);

    /// parabol özellikleri !!!
    final double _xScaling = size.width / 414;
    final double _yScaling = size.height / 896;
    path.lineTo(0 * _xScaling, 0 * _yScaling);
    path.cubicTo(
      0 * _xScaling,
      0 * _yScaling,
      0 * _xScaling,
      369.693 * _yScaling,
      0 * _xScaling,
      369.693 * _yScaling,
    );
    path.cubicTo(
      0 * _xScaling,
      369.693 * _yScaling,
      -14.3 * _xScaling,
      201.949 * _yScaling,
      91.8 * _xScaling,
      176.956 * _yScaling,
    );
    path.cubicTo(
      197.9 * _xScaling,
      151.96299999999997 * _yScaling,
      140.91 * _xScaling,
      82.686 * _yScaling,
      234.738 * _xScaling,
      64.735 * _yScaling,
    );
    path.cubicTo(
      328.56600000000003 * _xScaling,
      46.78399999999999 * _yScaling,
      310.809 * _xScaling,
      -44.417 * _yScaling,
      346.112 * _xScaling,
      0 * _yScaling,
    );
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class BackgroundPaint2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    Path path = Path();
    paint.color = Color.fromARGB(255, 84, 190, 229);

    /// parabol özellikleri !!!
    final double _xScaling = size.width / 414;
    final double _yScaling = size.height / 896;
    path.lineTo(414.00399999999996 * _xScaling, 694.949 * _yScaling);
    path.cubicTo(
      414.00399999999996 * _xScaling,
      694.949 * _yScaling,
      414.00399999999996 * _xScaling,
      895.999 * _yScaling,
      414.00399999999996 * _xScaling,
      895.999 * _yScaling,
    );
    path.cubicTo(
      414.00399999999996 * _xScaling,
      895.999 * _yScaling,
      0.10400000000000009 * _xScaling,
      895.999 * _yScaling,
      0.10400000000000009 * _xScaling,
      895.999 * _yScaling,
    );
    path.cubicTo(
      0.10400000000000009 * _xScaling,
      895.999 * _yScaling,
      -6.421 * _xScaling,
      835.599 * _yScaling,
      82.438 * _xScaling,
      813.1990000000001 * _yScaling,
    );
    path.cubicTo(
      171.297 * _xScaling,
      790.7990000000001 * _yScaling,
      170.678 * _xScaling,
      775.6310000000001 * _yScaling,
      222.968 * _xScaling,
      714.758 * _yScaling,
    );
    path.cubicTo(
      275.2579999999999 * _xScaling,
      653.885 * _yScaling,
      327.768 * _xScaling,
      619.818 * _yScaling,
      371.91799999999995 * _xScaling,
      641.514 * _yScaling,
    );
    path.cubicTo(
      416.0679999999999 * _xScaling,
      663.21 * _yScaling,
      414.00399999999996 * _xScaling,
      694.949 * _yScaling,
      414.00399999999996 * _xScaling,
      694.949 * _yScaling,
    );
    path.cubicTo(
      414.00399999999996 * _xScaling,
      694.949 * _yScaling,
      414.00399999999996 * _xScaling,
      694.949 * _yScaling,
      414.00399999999996 * _xScaling,
      694.949 * _yScaling,
    );
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}


/// ADMOB REKLAM FONKSİYONLARI
MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
   keywords: <String>['Technology','Tools',"Web","Mobile","Phone","Note","Pc","Productivity","Store"],
  nonPersonalizedAds: true,
  testDevices: <String>["fd917e6f-be30-4a49-88a0-8eb394d4562b","BDB8E3BDB82509F220537F09705A7DE9"], 
);


BannerAd myBanner = BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  //ca-app-pub-3940256099942544/6300978111
  //ca-app-pub-4377139267165661/2109217426
  adUnitId: "ca-app-pub-3940256099942544/6300978111",
  size: AdSize.largeBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);




_launchURL1() async {
    const url = "http://xmod.tech";
    if (await canLaunch(url)) {
      await launch(
        url,
        forceWebView: false,
        enableJavaScript: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},);
    } else {
      
      throw 'Could not launch ';
    }
  }



  Future<void> _launchInBrowser() async { 
    String url = "http://xmod.tech";
    if (await canLaunch(url))
     { await launch( url,
      forceSafariVC: false, forceWebView: false, 
      headers: <String, String>{'my_header_key': 'my_header_value'}, ); } else { 
        throw 'Could not launch $url'; 
        } }