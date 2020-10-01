class Movieinfo {
  dynamic popularity;
  dynamic vote_count;
  bool video;
  String poster_path;
  int id;
  bool adult;
  String backdrop_path;
  String original_language;
  String original_title;
  List<int> genre_ids;
  String title;
  dynamic vote_average;
  String overview;
  String release_date;

  Movieinfo(
      this.popularity,
      this.vote_count,
      this.video,
      this.poster_path,
      this.id,
      this.adult,
      this.backdrop_path,
      this.original_language,
      this.original_title,
      this.genre_ids,
      this.title,
      this.vote_average,
      this.overview,
      this.release_date);
}
