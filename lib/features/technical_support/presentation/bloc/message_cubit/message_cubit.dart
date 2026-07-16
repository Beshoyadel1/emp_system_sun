import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/theming/auth_local_storage.dart';
import '../../../../../features/technical_support/data/datasource/get_user_chats_datasource/get_user_chats_repository.dart';
import '../../../../../features/technical_support/data/request/get_user_chats_request/get_user_chats_request.dart';
import '../../../../../features/technical_support/presentation/bloc/message_cubit/message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageInitial());

  Future<void> getMessages() async {
    emit(MessageLoading());

    try {
      final user = await AuthLocalStorage.getUser();

      final messages = await getUserMessagesFunction(
        request: GetUserChatsRequest(
          userId: user?.userid??5,
          userType: user?.type ??4,
        ),
      );

      emit(MessageSuccess(messages));

    } catch (e) {
      emit(MessageError(e.toString()));
    }
  }
}