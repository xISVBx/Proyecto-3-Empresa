enum StorageKey {
  jwtToken,
  userId,
  themeMode,
  language,
}

extension StorageKeyExtension on StorageKey {
  String get key {
    switch (this) {
      case StorageKey.jwtToken:
        return "jwt_token";
      case StorageKey.userId:
        return "user_id";
      case StorageKey.themeMode:
        return "theme_mode";
      case StorageKey.language:
        return "language";
    }
  }
}
