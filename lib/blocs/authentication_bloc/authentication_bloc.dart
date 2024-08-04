 

import 'package:bloc/bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:new_project/Networks/StorageServices.dart';
import 'package:new_project/Networks/models/session_info.dart';
import 'package:new_project/Networks/services/auth_service.dart';
import 'package:new_project/blocs/authentication_bloc/authentication_event.dart';
import 'package:new_project/blocs/authentication_bloc/authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
      
  final AuthService _authService = AuthService();
  late String errorMessage;
  dynamic profileId = 0;
 
  AuthenticationBloc() : super(AuthenticationState()) {
    on<AuthenticationStatusChanged>((event, emit) async {
      // add(AuthenticationLogoutRequested());
      final accessToken = await LocalStorageService.instance
          .get(LocalStorageServiceItems.userToken);
      if (accessToken != null) {
        bool isTokenExpired = JwtDecoder.isExpired(accessToken);
        if (isTokenExpired) {
          await LocalStorageService.instance
              .delete(LocalStorageServiceItems.userToken);
          add(AuthenticationUnknownSessionEvent());
        } else {
          // await _authService.refreshToken();
          final id = await _authService.getProfileId();
          profileId = id;
          add(AuthenticationClientSessionEvent(
              SessionInfo(token: accessToken, id: id)));
        }
      } else {
        add(AuthenticationUnknownSessionEvent());
      }
    });

    on<AuthenticationUnknownSessionEvent>((event, emit) {
      emit(state.copyWith(status: SessionStatus.expired));
    });

    on<AuthenticationClientSessionEvent>((event, emit) {
      emit(state.copyWith(
          status: SessionStatus.valid, sessionInfo: event.sessionInfo));
    });

    on<AuthenticationLogoutRequested>((event, emit) async {
      await _authService.logout();
      emit(state.copyWith(
          status: SessionStatus.expired, message: 'Logged out successfully.'));
    });

    on<AuthenticationAccountDeleteRequested>((event, emit) async {
      await _authService.logout();
      emit(state.copyWith(
          status: SessionStatus.expired,
          message: 'Account deleted successfully.'));
    });
  }

  // Dispose of the StreamController when not needed
  @override
  Future<void> close() {
    // _sessionController.close();
    return super.close();
  }
}
