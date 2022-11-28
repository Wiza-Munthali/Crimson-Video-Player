import 'package:flutter/material.dart';

class VideoProvider with ChangeNotifier {
  bool _videoViewList = true;
  //late VideoPlayerController _videoPlayerController;

  bool _showControls = false;
  bool _showLeftIndicator = false;
  bool _showRightIndicator = false;
  bool _showCenterIndicator = false;

  bool _backgroundPlayback = false;

  bool get videoViewList => _videoViewList;
  bool get showControls => _showControls;
  bool get showLeftIndicator => _showLeftIndicator;
  bool get showRightIndicator => _showRightIndicator;
  bool get showCenterIndicator => _showCenterIndicator;
  bool get backgroundPlayback => _backgroundPlayback;

  void setBackgroundPlayback() {
    if (_backgroundPlayback) {
      _backgroundPlayback = false;
    } else {
      _backgroundPlayback = true;
    }
    notifyListeners();
  }

  void setShowControls() {
    Duration duration = Duration(seconds: 5);
    if (_showControls) {
      _showControls = false;
    } else {
      _showControls = true;
      Future.delayed(duration, () {
        _showControls = false;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  void setLeftIndicator() {
    Duration duration = Duration(seconds: 1);
    setAllIndicators();
    _showLeftIndicator = true;
    Future.delayed(duration, () {
      _showLeftIndicator = false;
      notifyListeners();
    });

    notifyListeners();
  }

  void setRightIndicator() {
    Duration duration = Duration(seconds: 1);
    setAllIndicators();
    _showRightIndicator = true;
    Future.delayed(duration, () {
      _showRightIndicator = false;
      notifyListeners();
    });

    notifyListeners();
  }

  void setCenterIndicator() {
    Duration duration = Duration(seconds: 2);
    setAllIndicators();
    _showCenterIndicator = true;
    Future.delayed(duration, () {
      _showCenterIndicator = false;
      notifyListeners();
    });

    notifyListeners();
  }

  void setAllIndicators() {
    _showLeftIndicator = false;
    _showRightIndicator = false;
    _showCenterIndicator = false;
  }

  //VideoPlayerController get videoPlayerController => _videoPlayerController;

  void toggleVideoViewList() {
    _videoViewList = !_videoViewList;
    notifyListeners();
  }

  //void videoPlayerControllerInitializer() {
  // _videoPlayerController = VideoPlayerController.asset(asset)
  //   ..addListener(() {
  //     notifyListeners();
  //   })
  //   ..setLooping(true)
  //   ..initialize().then((value) {
  //    _videoPlayerController.play();
  //    setShowControls();
  //  });
  //}

  //void playerDispose() {
  //  _videoPlayerController.dispose();
  //65}
}
