import 'package:hive/hive.dart';
import 'package:openpgp/openpgp.dart';

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
  final String publicKey;

  @HiveField(4)
  final String privateKey;

  Settings(
    this.password,
    this.resetPassword,
    this.isCompleteSettings,
    this.publicKey,
    this.privateKey
  );
}
