import 'dart:io';

import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/features/chat/data/models/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ChatMessageWidget extends StatelessWidget {
  final ChatMessage chatMessage;
  final String userId;
  final void Function() onResend;
  const ChatMessageWidget({
    super.key,
    required this.chatMessage,
    required this.onResend,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:
          userId == chatMessage.userId
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
      children: [
        if (userId == chatMessage.userId)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.r),
            child: SizedBox(
              width: 20.r,
              height: 20.r,
              child: Builder(
                builder: (context) {
                  if (chatMessage.loadStatus.isLoading) {
                    return const CircularProgressIndicator();
                  } else if (chatMessage.loadStatus.isFailed) {
                    return const Icon(Icons.upload);
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(13.r, 12.r, 13.r, 12.r),
              constraints: BoxConstraints(maxWidth: 0.8.sw),
              decoration: BoxDecoration(
                color: const Color(0x88F3FFF4),
                borderRadius: BorderRadius.circular(11.r),
              ),
              child: Builder(
                builder: (context) {
                  if (chatMessage.type.istext) {
                    return AppText.sp14(chatMessage.data);
                  } else {
                    if (chatMessage.type == ChatType.localFile) {
                      return ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 224.h,
                          minHeight: 180.h,
                        ),
                        child: Image.file(File(chatMessage.data)),
                      );
                    }
                    return CustomImage(chatMessage.data, height: 224.h);
                  }
                },
              ),
            ),
            4.verticalSpace,
            AppText.sp8(DateFormat('hh:mm a').format(chatMessage.date)),
          ],
        ),
      ],
    );
  }
}
