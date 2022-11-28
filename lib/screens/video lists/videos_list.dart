import 'dart:convert';
import 'package:animations/animations.dart';
import 'package:collection/collection.dart';
import 'package:crimson/models/video.dart';
import 'package:crimson/providers/index_provider.dart';
import 'package:crimson/screens/player/player.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_storage_path/flutter_storage_path.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../providers/video_provider.dart';
import 'package:intl/intl.dart';

class VideoList extends StatefulWidget {
  const VideoList({Key? key}) : super(key: key);

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  List<Video> _videos = <Video>[];
  List<Files> _files = <Files>[];
  late Future future;
  final formatDate = new DateFormat("dd MMM");
  String sortStyleSelected = "Date";
  String sortFormatSelected = "New to old";
  @override
  void initState() {
    future = getVideos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _deviceWidth = MediaQuery.of(context).size.width;
    double _deviceHeight = MediaQuery.of(context).size.height;

    return ScreenUtilInit(
        designSize: Size(_deviceWidth, _deviceHeight),
        minTextAdapt: true,
        builder: ((context, child) => FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        viewToggle(_deviceWidth, context),
                        Expanded(
                          child: changeListView(
                              context.watch<VideoProvider>().videoViewList,
                              _deviceWidth,
                              _videos),
                        ),
                      ],
                    ),
                    // ignore: dead_code
                    // Positioned(bottom: 0, child: MiniPlayer()),
                  ],
                ),
              );
            })));
  }

  sortFunction(String type, String format) {
    switch (type) {
      case "Date":
        if (format == "New to old") {
          _files.sort((a, b) => b.dateAdded!.compareTo(a.dateAdded.toString()));
          setState(() {});
        } else {
          _files.sort((a, b) => a.dateAdded!.compareTo(b.dateAdded.toString()));
          setState(() {});
        }
        break;
      case "Name":
        if (format == "A to Z") {
          _files.sort(
              (a, b) => a.displayName!.compareTo(b.displayName.toString()));
          setState(() {});
        } else {
          _files.sort(
              (a, b) => b.displayName!.compareTo(a.displayName.toString()));
          setState(() {});
        }
        break;
      case "Size":
        if (format == "Big to small") {
          _files
              .sort((a, b) => int.parse(b.size!).compareTo(int.parse(a.size!)));
          setState(() {});
        } else {
          _files
              .sort((a, b) => int.parse(a.size!).compareTo(int.parse(b.size!)));
          setState(() {});
        }
        break;
      case "Duration":
        if (format == "Long to short") {
          _files.sort((a, b) =>
              int.parse(b.duration!).compareTo(int.parse(a.duration!)));
          setState(() {});
        } else {
          _files.sort((a, b) =>
              int.parse(a.duration!).compareTo(int.parse(b.duration!)));
          setState(() {});
        }
        break;
      default:
    }
  }

  Widget viewToggle(width, BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.only(right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          PopupMenuButton(
            splashRadius: 10,
            position: PopupMenuPosition.under,
            icon: Icon(FluentIcons.arrow_sort_20_regular),
            itemBuilder: ((context) => <PopupMenuEntry<PopupMenuButton>>[
                  //Date
                  PopupMenuItem(
                    padding: EdgeInsets.zero,
                    child: PopupMenuButton(
                      splashRadius: 10,
                      position: PopupMenuPosition.under,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        width: 150.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Date"),
                            Icon(FluentIcons.timeline_24_regular),
                          ],
                        ),
                      ),
                      onSelected: (String result) {
                        setState(() {
                          sortFormatSelected = result;
                          sortStyleSelected = "Date";
                        });
                        Navigator.pop(context);
                        sortFunction(sortStyleSelected, sortFormatSelected);
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: "New to old",
                          child: Container(
                              width: 100.w, child: Text('New to old')),
                        ),
                        const PopupMenuItem<String>(
                          value: "Old to new",
                          child: Text("Old to new"),
                        ),
                      ],
                    ),
                  ),

                  //Name
                  PopupMenuItem(
                    padding: EdgeInsets.zero,
                    child: PopupMenuButton(
                      splashRadius: 10,
                      position: PopupMenuPosition.under,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        width: 150.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Name"),
                            Icon(FluentIcons.text_case_title_24_regular),
                          ],
                        ),
                      ),
                      onSelected: (String result) {
                        setState(() {
                          sortFormatSelected = result;
                          sortStyleSelected = "Name";
                        });
                        Navigator.pop(context);
                        sortFunction(sortStyleSelected, sortFormatSelected);
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: "A to Z",
                          child: Container(width: 100.w, child: Text('A to Z')),
                        ),
                        const PopupMenuItem<String>(
                          value: "Z to A",
                          child: Text("Z to A"),
                        ),
                      ],
                    ),
                  ),

                  //Size
                  PopupMenuItem(
                    padding: EdgeInsets.zero,
                    child: PopupMenuButton(
                      splashRadius: 10,
                      position: PopupMenuPosition.under,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        width: 150.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Size"),
                            Icon(FluentIcons.number_row_24_regular),
                          ],
                        ),
                      ),
                      onSelected: (String result) {
                        setState(() {
                          sortFormatSelected = result;
                          sortStyleSelected = "Size";
                        });
                        Navigator.pop(context);
                        sortFunction(sortStyleSelected, sortFormatSelected);
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: "Big to small",
                          child: Container(
                              width: 100.w, child: Text('Big to small')),
                        ),
                        const PopupMenuItem<String>(
                          value: "Small to big",
                          child: Text("Small to big"),
                        ),
                      ],
                    ),
                  ),

                  //Duration
                  PopupMenuItem(
                    padding: EdgeInsets.zero,
                    child: PopupMenuButton(
                      splashRadius: 10,
                      position: PopupMenuPosition.under,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        width: 150.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Duration"),
                            Icon(FluentIcons.timer_48_regular),
                          ],
                        ),
                      ),
                      onSelected: (String result) {
                        setState(() {
                          sortFormatSelected = result;
                          sortStyleSelected = "Duration";
                        });
                        Navigator.pop(context);
                        sortFunction(sortStyleSelected, sortFormatSelected);
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: "Long to short",
                          child: Container(
                              width: 100.w, child: Text('Long to short')),
                        ),
                        const PopupMenuItem<String>(
                          value: "Short to long",
                          child: Text("Short to long"),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
          IconButton(
              onPressed: () =>
                  {context.read<VideoProvider>().toggleVideoViewList()},
              icon: Icon(context.watch<VideoProvider>().videoViewList
                  ? FluentIcons.grid_20_regular
                  : FluentIcons.apps_list_detail_20_regular))
        ],
      ),
    );
  }

  Widget videoListView(double width) {
    return Container(
      //padding: const EdgeInsets.only(bottom: 80),
      width: width,
      child: Container(
        child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            controller: context.watch<IndexProvider>().scrollController,
            itemBuilder: (_, i) => videoListViewTile(width, _files[i]),
            itemCount: _files.length),
      ),
    );
  }

  Widget videoListViewByDate(date, videos, width) {
    return Container(
      child: Column(
        children: [
          //Date
          Text(
            formatDate.format(date),
            style: TextStyle(),
          ),

          Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  controller: context.watch<IndexProvider>().scrollController,
                  itemCount: videos.length,
                  itemBuilder: ((context, index) =>
                      videoListViewTile(width, videos[index]))))
        ],
      ),
    );
  }

  Widget videoListViewTile(width, Files video) {
    bool isPhone = width < 600;
    int? _videoDuration = int.tryParse(video.duration.toString());
    if (_videoDuration != null) {
      return OpenContainer(
        closedColor: Colors.transparent,
        transitionDuration: Duration(milliseconds: 500),
        openBuilder: ((context, action) => Player(
              video: video,
            )),
        closedBuilder: ((context, VoidCallback open) => Container(
              padding: const EdgeInsets.all(10),
              width: width,
              height: 150.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //Thumbnail & Time
                  Stack(
                    children: [
                      //Thumbnail
                      FutureBuilder<Uint8List?>(
                          future: getThumbNail(video.path.toString()),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              Uint8List? thumbnail = snapshot.data;
                              return Container(
                                width: isPhone ? width / 3 : width / 6,
                                height: 100.h,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Image.memory(thumbnail!),
                              );
                            }
                            return Container(
                              width: isPhone ? width / 3 : width / 6,
                              height: 100.h,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(5)),
                            );
                          }),

                      //Time
                      Positioned(
                        bottom: 1,
                        right: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                              height: 25.h,
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              child: Text(_duration(
                                  Duration(milliseconds: _videoDuration)))),
                        ),
                      )
                    ],
                  ),

                  //Title and location
                  Expanded(
                    child: Container(
                      height: 100.h,
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 30,
                              width: width,
                              child: Marquee(
                                text: video.displayName.toString(),
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600),
                                blankSpace: 10,
                                pauseAfterRound: Duration(seconds: 2),
                                startAfter: Duration(seconds: 2),
                              ),
                            ),
                            Text(
                              filesize(video.size.toString()),
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.w500),
                            ),
                            FittedBox(
                              child: Container(
                                height: 30.h,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      FluentIcons.folder_open_16_regular,
                                      size: 16.sp,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      video.album.toString(),
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            )),
      );
    }
    return SizedBox.shrink();
  }

  Widget videoGridView(double width) {
    bool isPhone = width < 600;
    return Container(
      //padding: const EdgeInsets.only(bottom: 80),
      width: width,
      alignment: Alignment.center,
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
                builder: (BuildContext ctx, BoxConstraints constraints) {
              return GridView.builder(
                primary: false,
                controller: context.watch<IndexProvider>().scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.0,
                    crossAxisCount: isPhone ? 3 : 4,
                    mainAxisSpacing: 10),
                itemCount: _files.length,
                padding: const EdgeInsets.all(10),
                itemBuilder: ((context, index) {
                  return videoGridViewTile(width, _files[index]);
                }),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget videoGridViewTile(width, Files video) {
    bool isPhone = width < 600;
    return OpenContainer(
      closedColor: Colors.transparent,
      transitionDuration: Duration(milliseconds: 500),
      closedBuilder: ((context, VoidCallback open) => Container(
            height: isPhone ? 150.h : 280.h,
            width: isPhone ? 150.w : 280.w,
            child: Stack(
              children: [
                //Thumbnail
                FutureBuilder<Uint8List?>(
                    future: getThumbNail(video.path.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Uint8List? thumbnail = snapshot.data;
                        return Container(
                          height: isPhone ? 150.h : 250.h,
                          width: isPhone ? 150.w : 250.w,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Image.memory(thumbnail!),
                        );
                      }
                      return Container(
                        height: isPhone ? 150.h : 250.h,
                        width: isPhone ? 150.w : 250.w,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                      );
                    }),

                //Time
                Positioned(
                  bottom: 1,
                  right: 1,
                  child: Padding(
                    padding:
                        isPhone ? EdgeInsets.all(10.0) : EdgeInsets.all(20.0),
                    child: Container(
                        height: 25.h,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        child: Text(_duration(Duration(
                            milliseconds:
                                int.parse(video.duration.toString()))))),
                  ),
                )
              ],
            ),
          )),
      openBuilder: ((context, action) => Player(
            video: video,
          )),
    );
  }

  changeListView(listType, width, List<Video> videos) {
    switch (listType) {
      case true:
        return Container(
          child: videoListView(width),
        );
      case false:
        return Container(
          child: videoGridView(width),
        );
    }
  }

  Future<void> getVideos() async {
    try {
      var source = await StoragePath.videoPath;
      var response = jsonDecode(source!);

      //_videos = response.map((e) => Video.fromJson(e)).toList();
      var _allFiles = response
          .map((e) => List<Files>.from(
              e["files"].map((item) => Files.fromJson(item)).toList()))
          .toList();

      List<Files> f = [];
      _allFiles.forEach((i) => f.addAll(i));
      _files.addAll(f);
      _files.forEach((element) {
        print("Element duration: ${element.duration}");
      });
      _files.removeWhere(((element) => element.duration == ""));
      sortFunction(sortStyleSelected, sortFormatSelected);
      //print(_allFiles);

    } catch (e) {
      print('Error: $e');
    }
  }

  String _duration(Duration duration) {
    try {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      if (duration.inHours != 0) {
        return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
      }

      return "$twoDigitMinutes:$twoDigitSeconds";
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<Uint8List?> getThumbNail(String path) async {
    final thumbnail = await VideoThumbnail.thumbnailData(
        video: path, imageFormat: ImageFormat.PNG, maxHeight: 100, quality: 25);
    return thumbnail;
  }
}
