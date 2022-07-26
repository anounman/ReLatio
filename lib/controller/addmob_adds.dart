import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Reward extends StatefulWidget {
  const Reward({Key? key}) : super(key: key);

  @override
  State<Reward> createState() => _RewardState();
}

class _RewardState extends State<Reward> {
  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  RewardedInterstitialAd? _rewardedInterstitialAd;
  int _numRewardedInterstitialLoadAttempts = 0;

  late BannerAd _bannerAd;
  bool _isAdLoaded = false;

  int maxAttempts = 3;
  int coin = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // creteRewardads();
    // createInterstitialAd();

    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          debugPrint(_.toString());
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          debugPrint('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    _bannerAd.load();
  }

  void creteRewardads() {
    RewardedAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/5224354917'
            : 'ca-app-pub-3940256099942544/1712485313',
        request: const AdRequest(),
        rewardedAdLoadCallback:
            RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
          debugPrint('$ad Load');
          _rewardedAd = ad;
        }, onAdFailedToLoad: (LoadAdError error) {
          debugPrint("$error LoadError");
          _rewardedAd = null;
          _numRewardedLoadAttempts += 1;
          if (_numRewardedLoadAttempts <= maxAttempts) {
            creteRewardads();
          }
        }));
  }

  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/1033173712'
            : 'ca-app-pub-3940256099942544/4411468910',
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            debugPrint('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxAttempts) {
              createInterstitialAd();
            }
          },
        ));
  }

  void showInterstitialAd() {
    if (_interstitialAd == null) {
      debugPrint('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          debugPrint('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
        showInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void _showRewardAds() {
    if (_rewardedAd == null) {
      debugPrint('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          debugPrint('$ad onAdShowedFullScreenContent'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        debugPrint('$ad onAdDismissedFullScreenContent');
        ad.dispose();
        creteRewardads();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        creteRewardads();
      },
    );
    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      setState(() {
        coin = coin + (reward.amount).toInt();
      });
      debugPrint('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedAd = null;
  }

  void _createRewardedInterstitialAd() {
    RewardedInterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/5354046379'
            : 'ca-app-pub-3940256099942544/6978759866',
        request: const AdRequest(),
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          onAdLoaded: (RewardedInterstitialAd ad) {
            debugPrint('$ad loaded.');
            _rewardedInterstitialAd = ad;
            _numRewardedInterstitialLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('RewardedInterstitialAd failed to load: $error');
            _rewardedInterstitialAd = null;
            _numRewardedInterstitialLoadAttempts += 1;
            if (_numRewardedInterstitialLoadAttempts < maxAttempts) {
              _createRewardedInterstitialAd();
            }
          },
        ));
  }

  void _showRewardedInterstitialAd() {
    if (_rewardedInterstitialAd == null) {
      debugPrint('Warning: attempt to show rewarded interstitial before loaded.');
      return;
    }
    _rewardedInterstitialAd!.fullScreenContentCallback =
        FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedInterstitialAd ad) =>
          debugPrint('$ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedInterstitialAd();
      },
      onAdFailedToShowFullScreenContent:
          (RewardedInterstitialAd ad, AdError error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedInterstitialAd();
      },
    );

    _rewardedInterstitialAd!.setImmersiveMode(true);
    _rewardedInterstitialAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      debugPrint('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedInterstitialAd = null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    _rewardedInterstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 72.0,
        child: AdWidget(
          ad: _bannerAd,
        ),
      ),
      body: Container(
        child: Center(
          child: InkWell(
            onTap: () => showInterstitialAd(),
            onLongPress: () => _showRewardAds(),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(20)),
              child: Center(child: Text(coin.toString())),
            ),
          ),
        ),
      ),
    );
  }
}
