import 'package:flutter/material.dart' ;
import 'dart:async' ;
import 'package:webview_flutter/webview_flutter.dart' ;
import 'package:flutter_no_internet_widget/flutter_no_internet_widget.dart' ;
import 'package:google_mobile_ads/google_mobile_ads.dart' ;
import 'package:wedding_pose/adhelp.dart' ;
import 'package:wedding_pose/hj.dart' ;
import 'package:google_mobile_ads/google_mobile_ads.dart' ;
import 'package:flutter/services.dart' ;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixel Plus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: Future.delayed(Duration(seconds: 3)),
        builder: (ctx, timer) =>
        timer.connectionState == ConnectionState.done
            ? InternetWidget(
          // ignore: avoid_print
            whenOffline: () => print('No Internet'), offline: FullScreenWidget(
          child: Scaffold(
            backgroundColor: Colors.black,
            body:  Center(child: Image.asset("assets/a/WhatsApp Image 2024-02-10 at 12.41.21_1e562e82.jpg", height: MediaQuery.of(context).size.height
                , fit : BoxFit.cover, width:MediaQuery.of(context).size.width )),
          ),
        ),
            // ignore: avoid_print
            whenOnline: () => MyWebViewPage(),
            loadingWidget: const Center(child: Text('Loading..')),
            online : MyWebViewPage()) //Screen to navigate to once the splashScreen is done.
            : Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image(
            image: AssetImage('assets/a/20240210_1453311.gif'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  String ds ;
   MyHomePage({super.key, required this.ds});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<InitializationStatus> _initGoogleMobileAds() {
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
            _interstitialAd = ad ;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }

  void startTimer() {
    // Create a periodic timer that runs the specified function every 30 seconds
    Timer.periodic(Duration(seconds: 120), (Timer timer) {
      // Call your function here
      print("Executing function every 30 seconds...");
      /*_loadInterstitialAd();
      _interstitialAd?.show();*/
      // Uncomment the next line to cancel the timer after a certain condition
      // if (someCondition) timer.cancel();
    });
  }

  late final WebViewController controller;
  double progress = 0.0;
  void initState(){
    _initGoogleMobileAds();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progres) {
            setState(() {
              progress = progres / 100;
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://cycledekhoj.in/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )..loadRequest(Uri.parse(widget.ds));
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
    setState(() {

    });
    startTimer();
  }

  bool b = true ;
  void check(){
    if( c >= 0 && c <= 2){
      setState((){
        b =  true ;
      });
    }else{
      setState((){
        b =  false ;
      });
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime? _lastPressedAt;
  BannerAd? _bannerAd;
  int c = 0 ;
  @override
  Widget build(BuildContext context) {
    int backButtonPressCount = 0;
    return  Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat, // Adjust as needed
      floatingActionButton: FloatingActionButton(
        onPressed : (){
          _refreshWebView();
        },
        child : Icon(Icons.refresh, color : Colors.blue)
      ),
      resizeToAvoidBottomInset: true ,
      bottomNavigationBar : Container(
        width : MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), // Adjust the radius as needed
            topRight: Radius.circular(25), // Adjust the radius as needed
          ),
          color: Colors.black,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children : [
                  IconButton(onPressed: () async {
                    check();
                    setState((){
                      c = 0 ;
                    });
                    Navigator.pop(context);
                    _refreshWebView();
                    }, icon:  Icon(Icons.home, size : 25, color : c == 0 ? Color(0xff009DAD) : Colors.white ),),
                  IconButton(onPressed: () async {
                    check();
                    setState((){
                      c = 1 ;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text('No Notifications receive'),
                      duration: const Duration(seconds: 1),
                    ));
                  }, icon:  Icon(Icons.message, size : 25, color : c == 1 ? Color(0xff009DAD) : Colors.white ),),

                     ]
            ),
      ], ),  ),
      key: _scaffoldKey ,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(10.0) , // Set the desired height
        child: AppBar(
          backgroundColor: Colors.black ,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(4.0) , // Set the desired height
            child: LinearProgressIndicator(
              value: progress ,
              backgroundColor: Colors.white ,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          ),
        ),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }

  Future<void> _refreshWebView() async {
    await controller.reload();
  }

  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    _bannerAd?.dispose();
    super.dispose();
  }
}
