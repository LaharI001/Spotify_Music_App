import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify/states/providers.dart';
import 'package:spotify/ui/playerPage.dart';
import 'package:spotify/ui/shared/currentlyPlayingThumbnail.dart';
import 'package:spotify/ui/shared/currentlyPlayingTitle.dart';
import 'package:spotify/ui/shared/playPauseButton.dart';
import 'package:spotify/ui/shared/playerSlider.dart';

class MiniPlayerWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currenlyPlaying = watch(currentlyPlayingProvider);
    return currenlyPlaying.when(
        data: (audioTrack) {
          if (audioTrack.isEmpty)
            return Container();
          else
            return AnimatedContainer(
              duration: Duration(seconds: 1),
              child: SizedBox(
                height: 61,
                child: Column(
                  children: [
                    PlayerSlider(
                      isMini: true,
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 8,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PlayerPage()));
                            },
                            child: Row(
                              children: [
                                Flexible(
                                    child: CurrentlyPlayingThumbnail(
                                  height: 60,
                                  width: 60,
                                )),
                                Flexible(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: CurrentlyPlayingText(
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: SizedBox(
                                height: 60,
                                width: 60,
                                child: PlayPauseButton(
                                  height: 20,
                                  width: 20,
                                  pauseIcon: Icons.pause,
                                  playIcon: Icons.play_arrow,
                                ),
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            );
        },
        loading: () => Container(),
        error: (_, __) => Container());
  }
}
