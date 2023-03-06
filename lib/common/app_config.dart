class AppConfig {
  static const String appName = 'Temp';
  static const String env = 'uat';

  ///Network
  static const baseUrl = 'https://hf-android-app.s3-eu-west-1.amazonaws.com';
  // static const baseUrl = (env == 'live' || env == '' || env == 'prod')
  //     ? ''
  //     : env == 'staging'
  //         ? ''
  //         : env == "uat"
  //             ? ""
  //             : '';
}
