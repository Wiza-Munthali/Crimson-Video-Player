import 'package:crimson/screens/folder%20lists/folder_list.dart';
import 'package:crimson/screens/settings/settings.dart';
import 'package:crimson/screens/video%20lists/videos_list.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidable/hidable.dart';
import 'package:provider/provider.dart';
import 'package:crimson/providers/index_provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _tabPages = <Widget>[
      const VideoList(),
      const FolderList(),
    ];

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return ScreenUtilInit(
        designSize: Size(_width, _height),
        minTextAdapt: true,
        builder: (context, child) => Scaffold(
              appBar: AppBar(
                title: Text(
                  'Crimson',
                  style:
                      TextStyle(fontSize: 36.sp, fontWeight: FontWeight.bold),
                ),
                actions: [
                  IconButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Settings())),
                      icon: Icon(FluentIcons.settings_32_regular))
                ],
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Hidable(
                  preferredWidgetSize: Size.fromHeight(60.h),
                  controller: context.watch<IndexProvider>().scrollController,
                  wOpacity: true,
                  child: BottomNavigationBar(
                    elevation: 0,
                    currentIndex: context.watch<IndexProvider>().index,
                    onTap: (value) =>
                        {context.read<IndexProvider>().setIndex(value)},
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    iconSize: 25.sp,
                    items: [
                      BottomNavigationBarItem(
                          icon: Icon(FluentIcons.video_clip_24_regular),
                          label: "Videos"),
                      BottomNavigationBarItem(
                          icon: Icon(FluentIcons.folder_24_regular),
                          label: "Folders"),
                    ],
                  ),
                ),
              ),
              body: _tabPages[context.watch<IndexProvider>().index],
            ));
  }
}
