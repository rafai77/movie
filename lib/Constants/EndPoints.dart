import 'Constants.dart';

class EndPoint {
  static const Popular = Constants.DOMAIN +
      Constants.Popular +
      Constants.KEY +
      Constants.Language +
      Constants.Page;
  static const Top = Constants.DOMAIN +
      Constants.Top_rated +
      Constants.KEY +
      Constants.Language +
      Constants.Page;
  static const Gener =
      Constants.DOMAING + "list?api_key=" + Constants.KEY + Constants.Language;
}
