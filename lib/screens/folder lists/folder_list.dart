import 'dart:convert';

import 'package:crimson/models/video.dart';
import 'package:crimson/screens/folder%20lists/folder_list_view.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_storage_path/flutter_storage_path.dart';

class FolderList extends StatefulWidget {
  const FolderList({Key? key}) : super(key: key);

  @override
  State<FolderList> createState() => _FolderListState();
}

class _FolderListState extends State<FolderList> {
  late Future future;
  List<Video> _videos = <Video>[];
  late ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController();
    future = getVideos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return ScreenUtilInit(
        designSize: Size(_width, _height),
        minTextAdapt: true,
        builder: ((context, child) => Container(
              child: FutureBuilder(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Container(
                    child: ListView.builder(
                        controller: _controller,
                        shrinkWrap: true,
                        itemCount: _videos.length,
                        itemBuilder: (context, index) => folderWidget(
                            _videos[index].folderName.toString(),
                            _videos[index].files)),
                  );
                },
              ),
            )));
  }

  Widget folderWidget(String name, List<Files> _files) {
    _files.removeWhere((element) => element.duration == "");
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => FolderListView(
                    name: name,
                    files: _files,
                  )))),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Icon(
            FluentIcons.folder_open_24_filled,
            size: 50.sp,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
              child: Container(
            height: 100.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        fontSize: 24.sp, fontWeight: FontWeight.w600)),
                Text("${_files.length} videos",
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).hintColor))
              ],
            ),
          ))
        ]),
      ),
    );
  }

  Future<void> getVideos() async {
    try {
      var source = await StoragePath.videoPath;
      var response = jsonDecode(source!);

      var data = response.map<Video>((e) => Video.fromJson(e)).toList();

      _videos = data;
    } catch (e) {
      print('Error: $e');
    }
  }
}
