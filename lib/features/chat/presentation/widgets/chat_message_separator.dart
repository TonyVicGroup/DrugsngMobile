import 'package:drugs_ng/core/extensions/datetime_extension.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/features/chat/data/models/chat_message.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatMessageSeparator extends StatelessWidget {
  final List<ChatMessage> messages;
  final int index;
  const ChatMessageSeparator({
    super.key,
    required this.messages,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final idx = messages.length - (index + 1);
    final chatMsg = messages[idx];
    if (idx == 0) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20.r),
        child: AppText.sp14(chatMsg.date.timeDifference),
      );
    } else {
      final prevMsg = messages[idx - 1];
      if (prevMsg.date.day != chatMsg.date.day) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 20.r),
          child: AppText.sp14(chatMsg.date.timeDifference),
        );
      }
    }
    return 20.verticalSpace;
  }
}
