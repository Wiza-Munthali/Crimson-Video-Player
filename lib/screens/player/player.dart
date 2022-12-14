import 'dart:io';
import 'package:crimson/models/video.dart';
import 'package:crimson/providers/video_provider.dart';
import 'package:crimson/reusables/popUpItem.dart';
import 'package:filesize/filesize.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_wake/flutter_screen_wake.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:marquee/marquee.dart';
import 'package:wakelock/wakelock.dart';
import 'package:simple_pip_mode/simple_pip.dart';
import 'package:simple_pip_mode/pip_widget.dart';
import 'package:path/path.dart' as p;

class Player extends StatefulWidget {
  final Files video;
  const Player({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  State<Player> createState() => _PlayerState(this.video);
}

class _PlayerState extends State<Player>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _animationController;
  late Tween<Duration> _tween;
  late Animation<Duration> _animation;
  //late VideoPlayerController _videoPlayerController;
  late VideoPlayerController _playerController;
  late TapDownDetails _details;
  final Files video;
  int counter = 0;
  Duration? position = Duration();
  double value = 0.0;
  bool _showProgress = false;
  late SimplePip _pip;
  bool pipAvailable = false;
  double? _volume;
  double? _brightness;
  bool _showVolume = false;
  bool _showBrightness = false;
  late bool backgroundInitialized;
  bool _backgroundPlayback = false;

  List<PopUpItem> playbackSpeedOptions = [
    new PopUpItem(false, 0.5, Icon(FluentIcons.multiplier_5x_48_regular)),
    new PopUpItem(true, 1.0, Icon(FluentIcons.multiplier_1x_48_regular)),
    new PopUpItem(false, 1.2, Icon(FluentIcons.multiplier_1_2x_48_regular)),
    new PopUpItem(false, 1.5, Icon(FluentIcons.multiplier_1_5x_48_regular)),
    new PopUpItem(false, 1.8, Icon(FluentIcons.multiplier_1_8x_48_regular)),
    new PopUpItem(false, 2.0, Icon(FluentIcons.multiplier_2x_48_regular)),
  ];

  _PlayerState(this.video);
  late File _file;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _pip = SimplePip();
    getCurrentVolume();
    _file = new File(video.path.toString());
    print("FILE: $_file");
    _playerController = VideoPlayerController.file(_file)
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true)
      ..initialize().then((value) {
        _playerController.play();
      });
    Wakelock.enable();
    PerfectVolumeControl.hideUI = true;
    _animationController =
        AnimationController(duration: Duration(milliseconds: 3), vsync: this);
    _tween = Tween(begin: position, end: _playerController.value.duration);
    _animation = _tween.animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    WidgetsBinding.instance.addObserver(this);
    requestPipAvailability();
    super.initState();
  }

  getCurrentVolume() async {
    _volume = await PerfectVolumeControl.getVolume();
    _brightness = await FlutterScreenWake.brightness;
  }

  /// Checks if system supports PIP mode
  Future<void> requestPipAvailability() async {
    var isAvailable = await SimplePip.isPipAvailable;
    setState(() {
      pipAvailable = isAvailable;
    });
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
        designSize: Size(_width, _height),
        minTextAdapt: true,
        builder: ((context, child) => Scaffold(
              body: SafeArea(
                child: PipWidget(
                  pipChild: Container(
                    decoration: BoxDecoration(color: Colors.black),
                    height: _height,
                    width: _width,
                    child: Stack(
                      children: [
                        videoContainer(context, _playerController),
                        _overLayControls(
                            _height, _width, _playerController, context, video)
                      ],
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black),
                    height: _height,
                    width: _width,
                    child: Stack(
                      children: [
                        videoContainer(context, _playerController),
                        _overLayControls(
                            _height, _width, _playerController, context, video)
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }

  @override
  void dispose() {
    // _videoPlayerController.dispose();
    _playerController.dispose();
    _animationController.dispose();
    resetPlayerOrientation();
    Wakelock.disable();
    WidgetsBinding.instance.removeObserver(this);
    PerfectVolumeControl.hideUI = false;
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState lifecycleState) {
    if (lifecycleState == AppLifecycleState.paused) {
      //_floating.enable(Rational.square());
      if (_backgroundPlayback) {
        setState(() {
          _playerController.play();
        });
      }
    }
  }

  // Future<void> enablePip() async {
  //   final status = await _floating.enable(Rational.landscape());
  //   debugPrint('PiP enabled? $status');
  // }

  Widget videoContainer(
      BuildContext context, VideoPlayerController controller) {
    return Center(
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: Stack(children: [
          // VideoPlayer(controller),
          VideoPlayer(controller),
          _overLayIndicators(controller),
        ]),
      ),
    );
  }

  Widget _overLayIndicators(VideoPlayerController controller) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Container(
      width: _width,
      height: _height,
      child: Stack(
        children: [
          context.watch<VideoProvider>().showLeftIndicator
              ? Container(
                  color: Colors.black38,
                  width: _width,
                  height: _height,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 50),
                  child: Icon(
                    FluentIcons.skip_back_10_48_regular,
                    size: 50.sp,
                  ),
                )
              : const SizedBox.shrink(),
          context.watch<VideoProvider>().showCenterIndicator
              ? Container(
                  color: Colors.black38,
                  width: _width,
                  height: _height,
                  alignment: Alignment.center,
                  child: Icon(
                    controller.value.isPlaying
                        ? FluentIcons.play_48_filled
                        : FluentIcons.pause_48_filled,
                    size: 50.sp,
                  ),
                )
              : const SizedBox.shrink(),
          _showProgress
              ? Container(
                  color: Colors.black38,
                  width: _width,
                  height: _height,
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: _width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_duration(position!),
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          width: _width / 5,
                          child: AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) => ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: LinearProgressIndicator(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                value: value,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(_duration(controller.value.duration),
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          _showVolume
              ? Container(
                  color: Colors.black38,
                  width: _width,
                  height: _height,
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: _width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(FluentIcons.speaker_2_48_filled),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          width: _width / 5,
                          child: AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) => ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: LinearProgressIndicator(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                value: _volume,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          _showBrightness
              ? Container(
                  width: _width,
                  height: _height,
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: _width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(FluentIcons.weather_sunny_48_filled),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          width: _width / 5,
                          child: AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) => ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: LinearProgressIndicator(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                value: _brightness,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          context.watch<VideoProvider>().showRightIndicator
              ? Container(
                  color: Colors.black38,
                  width: _width,
                  height: _height,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 50),
                  child: Icon(
                    FluentIcons.skip_forward_10_48_regular,
                    size: 50.sp,
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }

  Widget _overLayControls(double height, double width,
      VideoPlayerController controller, BuildContext context, Files video) {
    return Stack(children: [
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => context.read<VideoProvider>().setShowControls(),
        onDoubleTap: () => _doubleTap(controller),
        onDoubleTapDown: ((details) => _doubleTapFunctions(details)),
        onLongPress: () => HapticFeedback.mediumImpact(),
        onHorizontalDragUpdate: ((details) =>
            _dragToSeek(details, controller, context)),
        onHorizontalDragEnd: ((details) => _updatePosition(controller)),
        onVerticalDragUpdate: (details) => _updateVertical(details),
        onVerticalDragEnd: (details) => updateVolumeAndBrightness(),
      ),
      AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          reverseDuration: const Duration(milliseconds: 200),
          child: context.watch<VideoProvider>().showControls
              ? Container(
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _topControls(width, controller, context, video),
                      _bottomControls(width, controller, context),
                    ],
                  ),
                )
              : const SizedBox.shrink()),
    ]);
  }

  Widget _topControls(double width, VideoPlayerController controller,
      BuildContext context, Files video) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      width: width,
      height: 80.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(FluentIcons.arrow_left_48_filled)),
          Expanded(
            child: Marquee(
              text: video.displayName.toString(),
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
              blankSpace: 10,
              pauseAfterRound: Duration(seconds: 2),
              startAfter: Duration(seconds: 2),
            ),
          ),
          IconButton(
              onPressed: () => showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) =>
                      _moreControls(width, controller, context, video)),
              icon: Icon(FluentIcons.more_vertical_24_regular))
        ],
      ),
    );
  }

  Widget _bottomControls(
      double width, VideoPlayerController controller, BuildContext context) {
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    return Container(
      width: width,
      height: 120.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            width: width,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getVideoPosition(
                          controller.value.position.inMilliseconds.round()),
                      style: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(_duration(controller.value.duration),
                        style: TextStyle(
                            fontSize: 24.sp, fontWeight: FontWeight.bold)),
                  ],
                ),
                VideoProgressIndicator(controller, allowScrubbing: true),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Play & Pause
                Container(
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () => rewind(controller),
                          icon: Icon(FluentIcons.rewind_24_filled)),
                      IconButton(
                          onPressed: () => controller.value.isPlaying
                              ? controller.pause()
                              : controller.play(),
                          icon: controller.value.isPlaying
                              ? Icon(FluentIcons.pause_20_filled)
                              : Icon(FluentIcons.play_20_filled)),
                    ],
                  ),
                ),

                Row(
                  children: [
                    IconButton(
                        onPressed: () => pipAvailable ? enablePiPMode() : null,
                        icon: Icon(FluentIcons.resize_video_24_regular)),
                    IconButton(
                        onPressed: () => muteSound(controller),
                        icon: controller.value.volume == 1
                            ? Icon(FluentIcons.speaker_2_20_filled)
                            : Icon(FluentIcons.speaker_mute_20_filled)),
                    IconButton(
                        onPressed: () => changeLooping(controller),
                        icon: controller.value.isLooping
                            ? Icon(FluentIcons.arrow_repeat_1_24_filled)
                            : Icon(FluentIcons.arrow_repeat_all_24_filled)),
                    // IconButton(
                    //     onPressed: null,
                    //     icon: Icon(FluentIcons.closed_caption_48_filled)),
                    IconButton(
                        onPressed: () => changeOrientation(context),
                        icon: currentOrientation == Orientation.portrait
                            ? Icon(FluentIcons.full_screen_maximize_24_filled)
                            : Icon(FluentIcons.full_screen_minimize_24_filled)),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _moreControls(double width, VideoPlayerController controller,
      BuildContext context, Files video) {
    return GlassmorphicContainer(
      height: 350.h,
      width: width,
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      border: 1,
      blur: 10,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(105, 18, 18, 18),
          Color.fromARGB(105, 18, 18, 18),
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.transparent,
          Colors.transparent,
          Colors.transparent,
        ],
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () => _shareFile(XFile(video.path.toString())),
              child: Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      FluentIcons.share_48_regular,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text("Share",
                        style: TextStyle(
                            fontSize: 24.sp, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => popUpSettings(
                            playbackSpeedOptions, width, (index, value) {
                          playbackSpeedOptions
                              .forEach((element) => element.isSelected = false);
                          playbackSpeedOptions[index].isSelected = true;

                          controller.setPlaybackSpeed(
                              playbackSpeedOptions[index].value);
                          Navigator.pop(context);
                        }));
              },
              child: Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            FluentIcons.play_circle_48_regular,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text("Playback Speed",
                              style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    playbackSpeedOptions[playbackSpeedOptions.indexWhere(
                            (element) => element.isSelected == true)]
                        .icon
                  ],
                ),
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.pop(context);
            //     showModalBottomSheet(
            //         backgroundColor: Colors.transparent,
            //         context: context,
            //         builder: (context) =>
            //             captionsPopUp(width, controller, video));
            //   },
            //   child: Container(
            //     margin: const EdgeInsets.only(top: 20, bottom: 20),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Icon(
            //           FluentIcons.closed_caption_48_filled,
            //         ),
            //         SizedBox(
            //           width: 10.w,
            //         ),
            //         Text("Captions",
            //             style: TextStyle(
            //                 fontSize: 24.sp, fontWeight: FontWeight.w600)),
            //       ],
            //     ),
            //   ),
            // ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          FluentIcons.video_off_48_regular,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text("Background playback",
                            style: TextStyle(
                                fontSize: 24.sp, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  Switch(
                      activeColor: Theme.of(context).colorScheme.inversePrimary,
                      value: _backgroundPlayback,
                      onChanged: (bool newValue) {
                        print(newValue);
                        setState(() {
                          _backgroundPlayback = newValue;
                        });
                        Navigator.pop(context);
                      })
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => infoPopUp(width, controller, video));
              },
              child: Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      FluentIcons.info_28_regular,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text("Info",
                        style: TextStyle(
                            fontSize: 24.sp, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget popUpSettings(List<PopUpItem> items, width,
      void customFunction(int index, final value)) {
    return GlassmorphicContainer(
        height: 300.h,
        width: width,
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
        border: 1,
        blur: 10,
        linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(105, 18, 18, 18),
            Color.fromARGB(105, 18, 18, 18),
          ],
        ),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.transparent,
            Colors.transparent,
            Colors.transparent,
          ],
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: ((context, index) => Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: InkWell(
                    onTap: () => customFunction(index, items[index].value),
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          items[index].icon,
                          items[index].isSelected
                              ? Icon(FluentIcons.checkmark_48_regular)
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        ));
  }

  Widget captionsPopUp(
      double width, VideoPlayerController controller, Files video) {
    return GlassmorphicContainer(
      height: 300.h,
      width: width,
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      border: 1,
      blur: 10,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(105, 18, 18, 18),
          Color.fromARGB(105, 18, 18, 18),
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.transparent,
          Colors.transparent,
          Colors.transparent,
        ],
      ),
      child: Container(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Head
              Text("Captions",
                  style:
                      TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600)),

              //Rest
              Expanded(
                child: Container(
                  //padding: const EdgeInsets.only(top: 50, bottom: 50),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                FluentIcons.globe_search_24_regular,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text("Online source",
                                  style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                FluentIcons.slide_multiple_search_24_regular,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text("Local source",
                                  style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          )),
    );
  }

  Widget infoPopUp(
      double width, VideoPlayerController controller, Files video) {
    return GlassmorphicContainer(
      height: 300.h,
      width: width,
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      border: 1,
      blur: 10,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(105, 18, 18, 18),
          Color.fromARGB(105, 18, 18, 18),
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.transparent,
          Colors.transparent,
          Colors.transparent,
        ],
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
              child: Row(
            children: [
              Text(
                "Path :",
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Container(
                  height: 40.h,
                  child: Marquee(
                    text: video.path.toString(),
                    style:
                        TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400),
                    startAfter: Duration(seconds: 2),
                    pauseAfterRound: Duration(seconds: 2),
                    blankSpace: 20,
                  ),
                ),
              ),
            ],
          )),
          Container(
              child: Row(
            children: [
              Text(
                "Size :",
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                filesize(video.size.toString()),
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400),
              ),
            ],
          )),
          Container(
              child: Row(
            children: [
              Text(
                "Length :",
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                _duration(Duration(
                    milliseconds: controller.value.duration.inMilliseconds)),
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400),
              ),
            ],
          )),
          Container(
              child: Row(
            children: [
              Text(
                "Format :",
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                p.extension(video.path.toString()),
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400),
              ),
            ],
          )),
        ]),
      ),
    );
  }

  _shareFile(XFile _file) async {
    await Share.shareXFiles([_file]);
  }

  String _duration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours != 0) {
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }

    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Future setPlayerLandscape() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  Future resetPlayerOrientation() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  changeOrientation(BuildContext context) {
    var current = MediaQuery.of(context).orientation;

    if (current == Orientation.landscape) {
      resetPlayerOrientation();
    } else {
      setPlayerLandscape();
    }
  }

  rewind(VideoPlayerController controller) async {
    await controller.seekTo(Duration(seconds: 0));
  }

  _doubleTap(VideoPlayerController controller) async {
    bool? isInitialized = controller.value.isInitialized;
    if (isInitialized) {
      final _width = MediaQuery.of(context).size.width;
      final _x = _details.globalPosition.dx;
      final _middleWidth = _width / 2;
      Duration? currentPosition = await controller.position;

      if (_x <= _middleWidth - 100) {
        await HapticFeedback.lightImpact();
        Duration? position =
            currentPosition! + Duration(milliseconds: -10 * 1000);
        controller.seekTo(position);
        context.read<VideoProvider>().setLeftIndicator();
      } else if (_x >= _middleWidth + 100) {
        await HapticFeedback.lightImpact();
        Duration? position =
            currentPosition! + Duration(milliseconds: 10 * 1000);
        controller.seekTo(position);
        context.read<VideoProvider>().setRightIndicator();
      } else {
        bool current = controller.value.isPlaying;
        context.read<VideoProvider>().setCenterIndicator();
        if (current) {
          await controller.pause();
        } else {
          await controller.play();
        }
      }
    }
  }

  changeLooping(VideoPlayerController controller) async {
    bool current = controller.value.isLooping;

    await controller.setLooping(!current);
  }

  muteSound(VideoPlayerController controller) async {
    double current = controller.value.volume;

    if (current == 1) {
      await controller.setVolume(0.0);
    } else {
      await controller.setVolume(1.0);
    }
  }

  enablePiPMode() {
    context.read<VideoProvider>().setShowControls();
    _pip.enterPipMode(aspectRatio: [19, 9]);
  }

  getVideoPosition(int milli) {
    Duration duration = Duration(milliseconds: milli);
    return [duration.inMinutes, duration.inSeconds]
        .map((e) => e.remainder(60).toString().padLeft(2, "0"))
        .join(':');
  }

  _dragToSeek(DragUpdateDetails details, VideoPlayerController controller,
      BuildContext context) async {
    if (controller.value.isInitialized) {
      setState(() {
        _showProgress = true;
      });

      Offset x = details.delta;
      Duration? currentPosition = await controller.position;

      if (x.dx > 0) {
        counter++;
      } else if (x.dx < 0) {
        counter--;
      }

      position = currentPosition! + Duration(milliseconds: counter * 1000);
      if (position!.isNegative) {
        position = Duration(milliseconds: 0);
      } else if (position! >= controller.value.duration) {
        position = controller.value.duration;
      }

      final _value = controller.value.duration.inMilliseconds;
      String _x = (((100 * position!.inMilliseconds) / _value) / 100)
          .toStringAsFixed(1);

      value = double.parse(_x);
    }
  }

  _updatePosition(VideoPlayerController controller) async {
    bool isInitialized = controller.value.isInitialized;
    if (isInitialized) {
      try {
        controller.seekTo(position!);

        counter = 0;
      } catch (e) {
        print("e: $e");
        counter = 0;
      }
      setState(() {
        _showProgress = false;
      });
    }
  }

  _updateVertical(DragUpdateDetails details) {
    print("Update Vert: ${details.globalPosition.dy}");
    final _width = MediaQuery.of(context).size.width;
    final _x = details.globalPosition.dx;
    final _y = details.delta.dy;
    final _middleWidth = _width / 2;

    if (_x < _middleWidth) {
      print("Hey Left");
      setState(() {
        _showVolume = true;
      });
      if (_y < 0) {
        setState(() {
          _volume = _volume! + 0.01;
        });
      } else if (_y > 0) {
        setState(() {
          _volume = _volume! - 0.01;
        });
      }
      if (_showVolume) {
        double max = 1.0;
        double min = 0.0;

        if (_volume!.isNegative) {
          _volume = min;
        } else if (_volume! >= max) {
          _volume = max;
        }
        PerfectVolumeControl.setVolume(_volume!);
      }
    } else if (_x > _middleWidth) {
      print("Hey Right");
      setState(() {
        _showBrightness = true;
      });
      if (_y < 0) {
        setState(() {
          _brightness = _brightness! + 0.01;
        });
      } else if (_y > 0) {
        setState(() {
          _brightness = _brightness! - 0.01;
        });
      }
      if (_showBrightness) {
        double max = 1.0;
        double min = 0.0;

        if (_brightness!.isNegative) {
          _brightness = min;
        } else if (_brightness! >= max) {
          _brightness = max;
        }
        FlutterScreenWake.setBrightness(_brightness!);
      }
    }
  }

  updateVolumeAndBrightness() async {
    if (_showVolume) {
      setState(() {
        _showVolume = false;
      });
    } else {
      setState(() {
        _showBrightness = false;
      });
    }
  }

  _doubleTapFunctions(TapDownDetails details) {
    _details = details;
  }
}
