import 'package:cubit_network_example/bloc/user_event.dart';
import 'package:cubit_network_example/bloc/user_state.dart';
import 'package:cubit_network_example/models/user.dart';
import 'package:cubit_network_example/services/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// BLoC 8.0.0
class UserBloc extends Bloc<UserEvent, UserState> {
  final UsersRepository usersRepository;

  UserBloc(this.usersRepository) : super(UserEmptyState()) {
    on<UserLoadEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final List<User> _loadedUserList = await usersRepository.getAllUsers();
        emit(UserLoadedState(loadedUser: _loadedUserList));
      } catch (_) {
        emit(UserErrorState());
      }
    });
    on<UserClearEvent>((event, emit) async {
      emit(UserEmptyState());
    });
  }
}

// BLoC 7.2
// class UserBloc extends Bloc<UserEvent, UserState> {
//   final UsersRepository usersRepository;

//   UserBloc(this.usersRepository) : super(UserEmptyState());

//     @override
//   Stream<UserState> mapEventToState(UserEvent event) async* {
//     if (event is UserLoadEvent) {
//       yield UserLoadingState();
//       try {
//         final List<User> _loadedUserList = await usersRepository.getAllUsers();
//         yield UserLoadedState(loadedUser: _loadedUserList);
//       } catch (_) {
//         yield UserErrorState();
//       }
//     } else if (event is UserClearEvent) {
//       yield UserEmptyState();
//     }
//   }

// }

// BLoC 4.0
// class UserBloc extends Bloc<UserEvent, UserState> {
//   final UsersRepository usersRepository;
//   UserBloc({this.usersRepository}) : assert(usersRepository != null);

//   @override
//   UserState get initialState => UserEmptyState();

  // @override
  // Stream<UserState> mapEventToState(UserEvent event) async* {
  //   if (event is UserLoadEvent) {
  //     yield UserLoadingState();
  //     try {
  //       final List<User> _loadedUserList = await usersRepository.getAllUsers();
  //       yield UserLoadedState(loadedUser: _loadedUserList);
  //     } catch (_) {
  //       yield UserErrorState();
  //     }
  //   } else if (event is UserClearEvent) {
  //     yield UserEmptyState();
  //   }
  // }

// }