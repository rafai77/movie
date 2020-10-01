class Constants {
  static const String DOMAIN = "https://api.themoviedb.org/3/movie/";
  static const String KEY = "595e32f25275e35efeb06abe806493cf";
  static const String Popular = "popular?api_key=";
  static const String Top_rated = "top_rated?api_key=";
  static const String Language = "&language=en-US";
  static const String Page = "&page=";

  static int pag = 1;

  static void setPage(int x) {
    pag = x;
  }

  static int getPage() {
    return pag;
  }
}
