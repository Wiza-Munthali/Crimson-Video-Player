// import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';
// import 'package:marquee/marquee.dart';

// class CustomControlsWidget extends StatefulWidget {
//   final BetterPlayerController? controller;
//   final Function(bool visbility)? onControlsVisibilityChanged;
//   final String? name;
//   const CustomControlsWidget(
//       {Key? key, this.controller, this.onControlsVisibilityChanged, this.name})
//       : super(key: key);

//   @override
//   _CustomControlsWidgetState createState() => _CustomControlsWidgetState();
// }

// class _CustomControlsWidgetState extends State<CustomControlsWidget> {
//   @override
//   Widget build(BuildContext context) {
//     double _height = MediaQuery.of(context).size.height;
//     double _width = MediaQuery.of(context).size.width;
//     return Positioned.fill(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Align(
//             alignment: Alignment.topLeft,
//             child: Container(
//               //padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//               width: _width,
//               height: 80,
//               child: Expanded(
//                 child: Marquee(
//                   text: widget.name.toString(),
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
//                   blankSpace: 10,
//                   pauseAfterRound: Duration(seconds: 2),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Colors.purple.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       InkWell(
//                         onTap: () async {
//                           Duration? videoDuration = await widget
//                               .controller!.videoPlayerController!.position;
//                           setState(() {
//                             if (widget.controller!.isPlaying()!) {
//                               Duration rewindDuration = Duration(
//                                   seconds: (videoDuration!.inSeconds - 2));
//                               if (rewindDuration <
//                                   widget.controller!.videoPlayerController!
//                                       .value.duration!) {
//                                 widget.controller!.seekTo(Duration(seconds: 0));
//                               } else {
//                                 widget.controller!.seekTo(rewindDuration);
//                               }
//                             }
//                           });
//                         },
//                         child: Icon(
//                           Icons.fast_rewind,
//                           color: Colors.white,
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           setState(() {
//                             if (widget.controller!.isPlaying()!)
//                               widget.controller!.pause();
//                             else
//                               widget.controller!.play();
//                           });
//                         },
//                         child: Icon(
//                           widget.controller!.isPlaying()!
//                               ? Icons.pause
//                               : Icons.play_arrow,
//                           color: Colors.white,
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () async {
//                           Duration? videoDuration = await widget
//                               .controller!.videoPlayerController!.position;
//                           setState(() {
//                             if (widget.controller!.isPlaying()!) {
//                               Duration forwardDuration = Duration(
//                                   seconds: (videoDuration!.inSeconds + 2));
//                               if (forwardDuration >
//                                   widget.controller!.videoPlayerController!
//                                       .value.duration!) {
//                                 widget.controller!.seekTo(Duration(seconds: 0));
//                                 widget.controller!.pause();
//                               } else {
//                                 widget.controller!.seekTo(forwardDuration);
//                               }
//                             }
//                           });
//                         },
//                         child: Icon(
//                           Icons.fast_forward,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
