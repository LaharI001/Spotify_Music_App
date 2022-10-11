import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotify/states/providers.dart';
import 'package:spotify/ui/miniPlayer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFFe63946), Colors.black.withOpacity(0.6)],
                stops: [0.0, 0.4],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                tileMode: TileMode.repeated)),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                'My Awesome Playlist',
                style: GoogleFonts.barlow(
                    fontSize: 16, fontWeight: FontWeight.w500),
              ),
              centerTitle: true,
            ),
            PlaylistWidget()
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(child: MiniPlayerWidget()),
    );
  }
}

class AudioTrackTile extends ConsumerWidget {
  final int trackIndex;

  const AudioTrackTile({Key key, this.trackIndex}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final audioTrack = watch(playlistProvider)[trackIndex];
    final audioPlayer = watch(audioPlayerProvider);
    return ListTile(
      leading: Image.network(
        audioTrack.thumbnail,
        height: 60,
        width: 60,
        fit: BoxFit.cover,
      ),
      title: Text(audioTrack.trackName),
      subtitle: Text(audioTrack.artistName),
      onTap: () {
        audioPlayer.playlistPlayAtIndex(trackIndex);
      },
    );
  }
}

class PlaylistWidget extends ConsumerWidget {
  const PlaylistWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final playlist = watch(playlistProvider);
    return SliverList(
      delegate: SliverChildListDelegate(playlist
          .asMap()
          .entries
          .map((entry) => AudioTrackTile(
                trackIndex: entry.key,
              ))
          .toList()),
    );
  }
}
