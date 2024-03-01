import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wedding_pose/adhelp.dart';
import 'package:wedding_pose/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyWebViewPage extends StatefulWidget {
  @override
  _MyWebViewPageState createState() => _MyWebViewPageState();
}

class _MyWebViewPageState extends State<MyWebViewPage> {
  int c = 0 ;
  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }
  InterstitialAd? _interstitialAd;

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
            },
          );

          setState(() {
            _interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }
  int d = 0 ;

  void st() {
    // Create a periodic timer that runs the specified function every 30 seconds
     if(d == 2){
      // Call your function here
      print("Executing function every 30 seconds...");
      _loadInterstitialAd();
      _interstitialAd?.show();
      d = 0 ;
      // Uncomment the next line to cancel the timer after a certain condition
      // if (someCondition) timer.cancel();
    }
  }

  void initState(){
    _initGoogleMobileAds();
    setState(() {

    });
  }

  DateTime? _lastPressedAt;
  @override
  Widget build(BuildContext context){
    return WillPopScope(
      onWillPop: () async {
        if (_lastPressedAt == null || DateTime.now().difference(_lastPressedAt!) > Duration(seconds: 2)) {
            _lastPressedAt = DateTime.now();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Press back again to exit'),
                duration: Duration(seconds: 2),
              ),
            );
          return false; // Do not exit the app
        } else {
          return true; // Allow exit the app
        }
      },
      child: Container(
        width : MediaQuery.of(context).size.width,
        height : MediaQuery.of(context).size.height,
        decoration : BoxDecoration(
          image : DecorationImage(
            image : AssetImage("assets/backgroung.jpg"),
            fit: BoxFit.cover,
          )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
            bottomNavigationBar : SingleChildScrollView(
              child: Container(
                width : MediaQuery.of(context).size.width,
                height:  103,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25), // Adjust the radius as needed
                    topRight: Radius.circular(25), // Adjust the radius as needed
                  ),
                  color: Colors.black,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children : [
                          TextButton.icon(
                            label : Text("Priacy", style :TextStyle(color : Colors.white, fontSize : 10) ),
                            onPressed: () async {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('Redirecting to Privacy Policy Page'),
                              duration: const Duration(seconds: 4),
                            ));
                            setState((){
                              c = 0 ;
                              d ++ ;
                            });
                            st();
                            final Uri _url = Uri.parse('https://sites.google.com/view/policy-pixel-plus-/home');
                            if (!await launchUrl(_url)) {
                              throw Exception('Could not launch $_url');
                            }
                          }, icon: SvgPicture.asset(
                              "assets/Private policy.svg", height : 40,
                              semanticsLabel: 'Acme Logo'
                          ), ),

                          TextButton.icon(
                            label : Text("More Apps", style :TextStyle(color : Colors.white, fontSize : 10) ),
                            onPressed: () async {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('Redirecting to More Apps'),
                              duration: const Duration(seconds: 4),
                            ));
                            setState((){
                              c = 2 ;
                              d ++ ;
                            });
                            st();
                            final Uri _url = Uri.parse('https://play.google.com/store/apps/dev?id=7885407931161174976');
                            if (!await launchUrl(_url)) {
                              throw Exception('Could not launch $_url');
                            }
                          }, icon: SvgPicture.asset(
                              "assets/MORE APPS.svg", height : 40,
                              semanticsLabel: 'Acme Logo'
                          ),),
                          TextButton.icon(
                            label : Text("Youtube", style :TextStyle(color : Colors.white, fontSize : 10) ),
                            onPressed: () async {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('Redirecting to our Youtube Channel'),
                              duration: const Duration(seconds: 4),
                            ));
                            setState((){
                              c = 3 ;
                              d ++ ;
                            });
                            st();
                            final Uri _url = Uri.parse('https://youtube.com/@PixlePlus?si=mEwXXRn3OjuTVGq0');
                            if (!await launchUrl(_url)) {
                              throw Exception('Could not launch $_url');
                            }
                          }, icon: SvgPicture.asset(
                              "assets/YOUTUBE.svg", height : 40,
                              semanticsLabel: 'Acme Logo'
                          ),),
                        ]
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children : [
                          TextButton.icon(
                            label : Text("Home", style :TextStyle(color : Colors.white, fontSize : 10) ),
                            onPressed: () async {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('You are in home only'),
                              duration: const Duration(seconds: 4),
                            ));
                            setState((){
                              c = 0 ;
                              d ++ ;
                            });
                            st();
                          }, icon: SvgPicture.asset(
                              "assets/HOME.svg", height : 40,
                              semanticsLabel: 'Acme Logo'
                          ), ),
                         TextButton.icon(
                           label : Text("Alerts", style :TextStyle(color : Colors.white, fontSize : 10) ),
                           onPressed: () async {
                            setState((){
                              c = 0 ;
                              d ++ ;
                            });
                            st();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('No Notifications receive'),
                              duration: const Duration(seconds: 1),
                            ));
                          }, icon:  SvgPicture.asset(
                              "assets/NOTIFICATION.svg",  height : 40,
                              semanticsLabel: 'Acme Logo'
                          ),),
                          TextButton.icon(
                            label : Text("Refresh", style :TextStyle(color : Colors.white, fontSize : 10) ),
                            onPressed: () async {
                            setState((){
                              c = 0 ;
                              d ++ ;
                            });
                            st();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('Home Screen refreshed .... !'),
                              duration: const Duration(seconds: 1),
                            ));
                          }, icon: SvgPicture.asset(
                              "assets/REFRESH.svg", height : 40,
                              semanticsLabel: 'Acme Logo'
                          ),),
                        ]
                    ),
                  ], ),  ),
            ),
          body : SingleChildScrollView(
            child: Column(
              children : [
                Container(
                  height : 300,
                  width : MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50), // Adjust the radius as needed
                        bottomRight: Radius.circular(50), // Adjust the radius as needed
                      ),
                    image: DecorationImage(
                      image : AssetImage("assets/20240207_0814241 (1).gif"),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                SizedBox(height : 30),
                Container(
                  width : MediaQuery.of(context).size.width,
                  child : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      s(context, "assets/couple.jpg", "Couple",
                        "https://sites.google.com/view/coplepose/home"
                      ),
                      s(context, "assets/wedd.jpg", "Weeding",
                        "https://sites.google.com/view/weddingpose/home"
                      ),
                      s(context, "assets/pre-wedding.jpg", "Pre-Wedding",
                      "https://sites.google.com/view/pre-weeding/home"),
                    ],
                  )
                ),
                SizedBox(height : 20),
                Container(
                    width : MediaQuery.of(context).size.width,
                    child : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        s(context, "assets/close.jpg", "Close-ups",
                        "https://sites.google.com/view/clous-up-pose/home"),
                        s(context, "assets/girl.jpg", "Girls",
                        "https://sites.google.com/view/girl-pose/home"),
                        s(context, "assets/boy.jpg", "Boys",
                        "https://sites.google.com/view/boys-pose/home"),
                      ],
                    )
                ),
                SizedBox(height : 30),
                a(context, "assets/shopping.jpg", "Shopping",
                    "https://sites.google.com/view/shopping-shopping-/home"),
                SizedBox(height : 15),
                a(context, "assets/albums.jpg", "Albums",
                    "https://sites.google.com/view/albums-designs/home"),
              ]
            ),
          )
        ),
      ),
    );
  }
  Widget a(BuildContext context, String a1, String a2, String a3){
    return ListTile(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage(
          ds: a3,
        )));
      },
      leading:  Container(
        height : MediaQuery.of(context).size.width / 3 - 25,
        width : MediaQuery.of(context).size.width / 3 - 10,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image : AssetImage(a1),
              fit: BoxFit.cover,
            )
        ),
      ),
      title:  Text(a2, style: TextStyle(color : Colors.black, fontWeight: FontWeight.w800),),
    );
  }
  Widget s(BuildContext context, String a1, String a2, String link){
    return InkWell(
      onTap : (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage(
          ds: link,
        )));
      },
      child: Container(
        height : MediaQuery.of(context).size.width / 3 - 25,
        width : MediaQuery.of(context).size.width / 3 - 10,
        decoration: BoxDecoration(
          color : Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child : Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children : [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height : MediaQuery.of(context).size.width / 3 - 65,
                width : MediaQuery.of(context).size.width / 3 - 10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10), // Adjust the radius as needed
                      topRight: Radius.circular(10), // Adjust the radius as needed
                    ),
                    image: DecorationImage(
                      image : AssetImage(a1),
                      fit: BoxFit.cover,
                    )
                ),
              ),
            ),
            Text(a2, style: TextStyle(color : Colors.yellow, fontWeight: FontWeight.w800),),
            ]
        )
      ),
    );
  }
}
