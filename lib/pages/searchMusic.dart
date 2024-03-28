import 'package:chatmusic/models/playlist_provider.dart';
import 'package:chatmusic/pages/popupSongPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:chatmusic/models/song.dart';

class searchMusic extends StatefulWidget {
  const searchMusic({super.key});

  @override
  State<searchMusic> createState() => _searchMusicState();
}

class _searchMusicState extends State<searchMusic> {
  late final PlaylistProvider playlistProvider;

  @override
  void initState() {
    super.initState();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  void goToSong(int songIndex) {
    playlistProvider.currentSongIndex = songIndex;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PopupSong()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(30.0, 20.0, 8.0, 3.0),
                child: Text(
                  'Search List',
                  style: TextStyle(
                    fontFamily: 'atma',
                    fontSize: 35,
                    color: Color(0xFFFF6B00),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<PlaylistProvider>(builder: (context, value, child) {
                // get playlist
                final List<Song> playlist = value.playlist;
                // return List view UI
                return ListView.builder(
                  itemCount: playlist.length,
                  itemBuilder: (context, index) {
                    //get individual
                    final Song song = playlist[index];
        
                    //return list tile UI
                    return ListTile(
                      title: Row(
                        children: [
                          Text(
                            '${index + 1} ',
                            style: TextStyle(
                              fontFamily: 'atma',
                              fontSize: 25,
                              color: Color(0xFFFF6B00),
                            ),
                          ),
                          SizedBox(width: 20),
                          Image.asset(
                            song.albumArtImagePath,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 8.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                song.songName,
                                style: TextStyle(
                                  fontFamily: 'atma',
                                  color: Color(0xFFFF6B00),
                                ),
                              ),
                              Text(
                                song.artistName,
                                style: TextStyle(
                                  fontFamily: 'atma',
                                  color: Color(0xFFFF6B00),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          setState(() {
                            song.isFavorite = !song.isFavorite;
                          });
                        },
                        child: Icon(
                          song.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: song.isFavorite ? Colors.red : Color(0xFFFF6B00),
                        ),
                      ),
                      onTap: () => goToSong(index),
                    );
                  },
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.secondary,
                          contentPadding: const EdgeInsets.all(6),
                          hintText: 'Search',
                          hintStyle: const TextStyle(
                            fontFamily: 'Inter',
                            color: Color(0xFFFF6B00),
                            fontSize: 14,
                          ),
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.search,
                              size: 20,
                              color: Color(0xFFFF6B00),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.send,
                    color: Color(0xFFFF6B00),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
