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

  Settings(
    this.password,
    this.resetPassword,
    this.isCompleteSettings
  );
}
