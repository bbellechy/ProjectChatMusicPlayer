class Song{
  final String songName;
  final String artistName;
  final String albumArtImagePath;
  final String audioPath;
  bool isFavorite;

Song({
  required this.songName,
  required this.artistName,
  required this.albumArtImagePath,
  required this.audioPath,
  this.isFavorite = false
});
}
