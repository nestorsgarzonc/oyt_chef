import 'package:equatable/equatable.dart';
import 'package:oyt_chef/features/auth/models/check_chef_response.dart';
import 'package:oyt_front_auth/models/auth_model.dart';
import 'package:oyt_front_core/wrappers/state_wrapper.dart';

class AuthState extends Equatable {
  const AuthState({
    required this.authModel,
    required this.checkChefResponse,
  });

  factory AuthState.initial() {
    return AuthState(
      authModel: StateAsync.initial(),
      checkChefResponse: StateAsync.initial(),
    );
  }

  final StateAsync<AuthModel> authModel;
  final StateAsync<CheckChefResponse> checkChefResponse;

  AuthState copyWith({
    StateAsync<AuthModel>? authModel,
    StateAsync<CheckChefResponse>? checkChefResponse,
  }) {
    return AuthState(
      authModel: authModel ?? this.authModel,
      checkChefResponse: checkChefResponse ?? this.checkChefResponse,
    );
  }

  @override
  List<Object?> get props => [authModel];
}
