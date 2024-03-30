import 'package:hive/hive.dart';

part 'settings.g.dart';

@HiveType(typeId: 1)
class Settings extends HiveObject {
  @HiveField(0)
  final String password;

  @HiveField(1)
  final String resetPassword;

  @HiveField(2)
  final bool isCompleteSettings;

  @HiveField(3)
  final String name;

  @HiveField(4)
  final String email;

  @HiveField(5)
  final String passphrase;

  @HiveField(6)
  final String keyOptions;

  Settings(
    this.password,
    this.resetPassword,
    this.isCompleteSettings,
    this.name,
    this.email,
    this.passphrase,
    this.keyOptions
  );
}
