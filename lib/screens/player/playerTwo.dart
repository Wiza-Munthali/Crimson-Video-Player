// import 'package:flutter/material.dart';
// import 'package:better_player/better_player.dart';
// import 'custom_controls.dart';

// class PlayerTwo extends StatefulWidget {
//   final String fileName;
//   final String path;
//   const PlayerTwo({Key? key, required this.fileName, required this.path})
//       : super(key: key);

//   @override
//   State<PlayerTwo> createState() => _PlayerTwoState(fileName, path);
// }

// class _PlayerTwoState extends State<PlayerTwo> {
//   final String fileName;
//   final String path;

//   late BetterPlayerController videoController;

//   _PlayerTwoState(this.fileName, this.path);

//   @override
//   void initState() {
//     BetterPlayerDataSource source =
//         BetterPlayerDataSource(BetterPlayerDataSourceType.file, path);

//     videoController = BetterPlayerController(
//         BetterPlayerConfiguration(
//             allowedScreenSleep: false,
//             autoPlay: true,
//             controlsConfiguration: BetterPlayerControlsConfiguration(
//                 playerTheme: BetterPlayerTheme.custom,
//                 customControlsBuilder: ((controller,
//                         onPlayerVisibilityChanged) =>
//                     CustomControlsWidget(
//                       controller: controller,
//                       onControlsVisibilityChanged: onPlayerVisibilityChanged,
//                       name: fileName,
//                     )))),
//         betterPlayerDataSource: source);

//     videoController.addEventsListener((BetterPlayerEvent event) {
//       if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
//         videoController.setOverriddenAspectRatio(
//             videoController.videoPlayerController!.value.aspectRatio);
//         setState(() {});
//       }

//       if (event.betterPlayerEventType == BetterPlayerEventType.openFullscreen) {
//         print("Hie");
//       }
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double _height = MediaQuery.of(context).size.height;
//     double _width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           height: _height,
//           width: _width,
//           decoration: BoxDecoration(color: Colors.black),
//           child: Center(
//             child: AspectRatio(
//               aspectRatio:
//                   videoController.videoPlayerController!.value.aspectRatio,
//               child: BetterPlayer(controller: videoController),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     videoController.dispose();
//     super.dispose();
//   }

//   final controls = BetterPlayerControlsConfiguration();
// }
