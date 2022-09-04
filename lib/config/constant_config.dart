import 'dart:ui';

class Config {
  static final String baseUrl = "https://go-server-app.herokuapp.com";
  static final String baseUrlAuth = "https://go-server-app.herokuapp.com/v1";
  static final String versionCode = "1";
}

class Locales {
  static const Locale en = Locale('en', 'US');
  static const Locale id = Locale('id', 'ID');

  static const List<Locale> supported = [en, id];

  static String language(Locale locale) {
    return (locale == en) ? 'English' : 'Indonesia';
  }
}

enum MarketType {
  CandlePattern,
  SupportAndResistance,
  StochasticOversoldAndOverBought
}

class Watchlist {
  static final List<Map> currencyPair = [
    {
      'id': 'EURUSD',
      'name': 'EUR/USD',
    },
    {
      'id': 'USDJPY',
      'name': 'USD/JPY',
    },
    {
      'id': 'GBPUSD',
      'name': 'GBP/USD',
    },
    {
      'id': 'USDCHF',
      'name': 'USD/CHF',
    },
    {
      'id': 'AUDUSD',
      'name': 'AUD/USD',
    },
    {
      'id': 'USDCAD',
      'name': 'EUR/USD',
    },
    {
      'id': 'NZDUSD',
      'name': 'NZD/USD',
    },
    {
      'id': 'XAUUSD',
      'name': 'XAU/USD',
    },
    {
      'id': 'XAGUSD',
      'name': 'XAG/USD',
    },
    {
      'id': 'CLSK',
      'name': 'CLSK (Oil)',
    },
    {
      'id': 'EURJPY',
      'name': 'EUR/JPY',
    },
    {
      'id': 'AUDJPY',
      'name': 'AUD/JPY',
    },
    {
      'id': 'AUDNZD',
      'name': 'AUD/NZD',
    },
    {
      'id': 'CHFJPY',
      'name': 'CHF/JPY',
    },
    {
      'id': 'EURAUD',
      'name': 'EUR/AUD',
    },
    {
      'id': 'EURCAD',
      'name': 'EUR/CAD',
    },
    {
      'id': 'EURGBP',
      'name': 'EUR/GBP',
    },
    {
      'id': 'GBPAUD',
      'name': 'GBP/AUD',
    },
    {
      'id': 'GBPCHF',
      'name': 'GBP/CHF',
    },
    {
      'id': 'GBPJPY',
      'name': 'GBP/JPY',
    },
    {
      'id': 'EURCHF',
      'name': 'EUR/CHF',
    },
  ];

  static final List<String> currencyPairString = [
    'EURUSD',
    'USDJPY',
    'GBPUSD',
    'USDCHF',
    'AUDUSD',
    'USDCAD',
    'NZDUSD',
    'XAUUSD',
    'XAGUSD',
    'CLSK',
    'EURJPY',
    'AUDJPY',
    'AUDNZD',
    'CHFJPY',
    'EURAUD',
    'EURCAD',
    'EURGBP',
    'GBPAUD',
    'GBPCHF',
    'GBPJPY',
    'EURCHF',
  ];
}

class PromoRedirectType {
  static const int OPEN_WEBVIEW = 0;
  static const int REDIRECT_URL = 1;
  static const int REDIRECT_PAGE = 2;
  static const int OPEN_WEBVIEW_WITH_BOTTOM_NAVIGATOR = 3;
}

class TradeConst {
  static const String TRADE_NEW = 'new';
  static const String TRADE_MODIFY = 'modify';
  static const String TRADE_CLOSE = 'close';
}
