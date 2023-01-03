import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oyt_chef/features/auth/data_source/auth_datasource.dart';
import 'package:oyt_chef/features/auth/models/check_chef_response.dart';
import 'package:oyt_front_auth/data_source/auth_datasource.dart';
import 'package:oyt_front_core/failure/failure.dart';
import 'package:oyt_front_auth/repositories/auth_repositories.dart';

final authRepositoryProvider = Provider<ChefAuthRepository>((ref) {
  return ChefAuthRepository.fromRead(ref);
});

class ChefAuthRepository extends AuthRepositoryImpl {
  ChefAuthRepository({required this.chefAuthDatasource, required super.authDatasource});

  factory ChefAuthRepository.fromRead(Ref ref) {
    final chefAuthDatasource = ref.read(chefAuthDatasourceProvider);
    final authDatasource = ref.read(authDatasourceProvider);
    return ChefAuthRepository(
      chefAuthDatasource: chefAuthDatasource,
      authDatasource: authDatasource,
    );
  }

  final ChefAuthDataSource chefAuthDatasource;

  Future<Either<Failure, CheckChefResponse>> checkIfIsChef() async {
    try {
      final res = await chefAuthDatasource.checkIfIsChef();
      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
