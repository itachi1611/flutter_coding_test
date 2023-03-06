enum LoadStatus {
  initial,
  loading,
  success,
  fail,
}

enum ConnectionStatus {
  mobileOnline('Mobile network connected'),
  mobileOffline('Mobile network problem'),
  wifiOnline('Wifi network connected'),
  wifiOffline('Wifi network problem'),
  offline('No network');

  final String message;

  const ConnectionStatus(this.message);
}

enum FlushType {
  notification,
  success,
  warning,
  error,
}

enum FirstRunNavigationType {
  firstRun,
  notFirstRun,
}

enum LaunchExternalType {
  sms('sms'),
  tel('tel'),
  mail('mailto'),
  webview('https'),
  file('file');

  final String type;

  const LaunchExternalType(this.type);
}
