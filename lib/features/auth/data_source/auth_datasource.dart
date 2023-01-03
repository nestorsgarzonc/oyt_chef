import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oyt_chef/features/auth/models/check_chef_response.dart';
import 'package:oyt_front_core/external/api_handler.dart';
import 'package:oyt_front_core/external/db_handler.dart';
import 'package:oyt_front_core/logger/logger.dart';

final chefAuthDatasourceProvider = Provider<ChefAuthDataSource>((ref) {
  return ChefAuthDatasourceImpl.fromRead(ref);
});

abstract class ChefAuthDataSource {
  Future<CheckChefResponse> checkIfIsChef();
}

class ChefAuthDatasourceImpl implements ChefAuthDataSource {
  factory ChefAuthDatasourceImpl.fromRead(Ref ref) {
    final apiHandler = ref.read(apiHandlerProvider);
    final dbHandler = ref.read(dbHandlerProvider);
    return ChefAuthDatasourceImpl(apiHandler, dbHandler);
  }

  const ChefAuthDatasourceImpl(this.apiHandler, this.dbHandler);

  final ApiHandler apiHandler;
  final DBHandler dbHandler;

  @override
  Future<CheckChefResponse> checkIfIsChef() async {
    try {
      final res = await apiHandler.get('/auth/is-chef');
      return CheckChefResponse.fromMap(res.responseMap!);
    } catch (e, s) {
      Logger.logError(e.toString(), s);
      rethrow;
    }
  }
}
