class ApiConstant {
  static final String BASE_URL = 'http://api.themoviedb.org/3/';

  static const  String API_KEY = "?api_key=************yourkey**********";

  static final GET_TOKEN="authentication/token/new";
  static final GET_SESSION="authentication/session/new";
  static const LOGin_WITH_TMDB="authentication/token/validate_with_login";
  static const GET_ACCOUNT="account";
  static const SESSION_ID="&session_id=";
  static const WATCHLIST="/watchlist";
  static const FAVOURITE="/favorite";
  static const FAVOURIT_TV="/favorite/tv";
  static const WATCHLIST_TV= "/watchlist/tv";
  static const WATCHLIST_MOVIES = "/movies";
  static const NOW_PLAYING = 'movie/now_playing';
  static const POPULAR_MOVIES = 'movie/popular';
  static const GENRES_LIST = "genre/movie/list";
  static const TRENDING_MOVIE_LIST = "trending/movie/";

  static const DISCOVER_MOVIE = 'discover/movie';
  static const UPCOMING_MOVIE = 'movie/upcoming';
  static const TOP_RATED = 'movie/top_rated';
  static const SEARCH_MOVIES = 'search/movie';
  static const SEARCH_QUERY = "&query=";

  static const DISCOVER_TV = 'discover/tv';
  static const SEARCH_TV = 'search/tv';
  static const SORT_TV = '&sort_by=';
  static const TV_DETAILS = 'tv/';


  static const MOVIE_DETAILS = 'movie/';
  static const CREDITS_CREW = '/credits';
  static const SIMILAR_MOVIES = '/similar';

  static var TRENDING_PERSONS = "trending/person/";
  static var PERSONS_DETAILS = "person/";
  static const SEARCH_PERSON = 'search/person';


  static var IMAGE_ORIG_POSTER = 'https://image.tmdb.org/t/p/original';

}