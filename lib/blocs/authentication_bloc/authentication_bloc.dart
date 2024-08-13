import 'package:bloc/bloc.dart';
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
      final loggedIn = await _authService.checkLoggedIn();
      if (loggedIn) {
        add(const AuthenticationClientSessionEvent(
            SessionInfo(token: 'access_token', id: '123')));
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
