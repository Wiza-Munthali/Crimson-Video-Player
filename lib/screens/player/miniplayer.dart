import 'package:animations/animations.dart';
import 'package:crimson/screens/player/player.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class MiniPlayer extends StatefulWidget {
  MiniPlayer({Key? key}) : super(key: key);

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.only(left: 5),
      width: _width,
      height: 80,
      decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.background),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Row(children: [
              //Thumbnail
              Container(
                width: 100,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
              ),

              SizedBox(
                width: 5,
              ),
              //Name
              Text('Name ',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ]),
          ),

          //Buttons
          Expanded(
            flex: 1,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //play
                  OpenContainer(
                    closedColor: Colors.transparent,
                    transitionDuration: Duration(milliseconds: 500),
                    openBuilder: ((context, action) => Container()),
                    closedBuilder: ((context, VoidCallback open) => IconButton(
                        onPressed: open,
                        icon: Icon(
                          FluentIcons.play_12_regular,
                          size: 20,
                        ))),
                  ),

                  //Next
                  IconButton(
                      onPressed: null,
                      icon: Icon(
                        FluentIcons.next_16_regular,
                        size: 20,
                      ))
                ]),
          ),
        ],
      ),
    );
  }
}
