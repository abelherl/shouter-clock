// https://dart.dev/guides/language/effective-dart/style#prefer-using-lowercamelcase-for-constant-names

// App flavor to determine logging and other configurations
enum Flavor {
  development,
  staging,
  production,
}

// OS type constant with string
class OSType {
  static const String android = 'android';
  static const String ios = 'ios';
}

// Sorting constant
class Sort {
  static const String asc = 'asc';
  static const String desc = 'desc';
}
