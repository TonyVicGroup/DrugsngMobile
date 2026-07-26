import 'dart:developer';
import 'dart:io';

import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/popup/app_toast.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/chat/data/models/chat_message.dart';
import 'package:drugs_ng/features/chat/presentation/widgets/chat_message_separator.dart';
import 'package:drugs_ng/features/chat/presentation/widgets/chat_message_widget.dart';
import 'package:drugs_ng/features/consultation/data/models/consultation_details.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pubnub/pubnub.dart';

class ConsultationChatPage extends StatefulWidget {
  const ConsultationChatPage({super.key, required this.consultation});

  final ConsultationDetails consultation;

  @override
  State<ConsultationChatPage> createState() => _ConsultationChatPageState();
}

class _ConsultationChatPageState extends State<ConsultationChatPage> {
  // late PubNub pubnub;
  // late Subscription subscription;
  late final String channelName;
  late final String userId;
  final TextEditingController textController = TextEditingController();
  ValueNotifier<List<ChatMessage>> messages = ValueNotifier([]);
  bool isUserOnline = false;
  Set<String> loadingChatIds = {};

  @override
  void initState() {
    super.initState();
    final id = context.read<AuthCubit>().state.account?.userId ?? 0;
    channelName = 'Consultation-${widget.consultation.id}';
    userId = 'user-$id';
    _initializePubNub();
  }

  @override
  void dispose() {
    textController.dispose();
    messages.dispose();
    super.dispose();
  }

  void _initializePubNub() async {
    // pubnub = PubNub(
    //   defaultKeyset: Keyset(
    //     subscribeKey: AppUtils.pubNubSubscribeKey,
    //     publishKey: AppUtils.pubNubPublishKey,
    //     userId: UserId(userId),
    //   ),
    // );

    // subscription = pubnub.subscribe(channels: {channelName});
    // subscription.messages.listen((envelope) {
    //   // envelope.uuid.value;
    //   log(envelope.content);
    //   final message = ChatMessage.fromJson(envelope.content as String);
    //   log(message.data);
    //   updateFile(message);
    // });
    // subscription.presence.listen((event) {
    //   setState(() {
    //     isUserOnline =
    //         event.occupancy > 1; // More than 1 means someone else is online
    //   });
    // });
    // // populate message data
    // isUserOnline = (await subscription.presence.first).occupancy <= 1;
    // final msgs = await subscription.messages.toList();
    // messages.value =
    //     msgs.map((msg) => ChatMessage.fromJson(msg.content as String)).toList();
  }

  void _sendMessage(String text) async {
    if (text.isNotEmpty) {
      AppUtils.removeKeyboard();
      final id = addTextData(text);
      resendData(id);
      textController.clear();
    } else {
      AppToast.warn(context, title: 'Warning', msg: 'Please enter a message');
    }
  }

  Future<void> _sendImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      String id = addImageData(pickedFile.path);
      resendImage(id);
    }
  }

  String addTextData(String text) {
    final localMsg = ChatMessage.text(text, userId);
    final msg = [...messages.value, localMsg];
    loadingChatIds.add(localMsg.id);
    messages.value = msg;
    return localMsg.id;
  }

  String addImageData(String path) {
    final localMsg = ChatMessage.image(path, userId);
    final msg = [...messages.value, localMsg];
    loadingChatIds.add(localMsg.id);
    messages.value = msg;
    return localMsg.id;
  }

  void updateFileFailedStatus(String id) {
    final msg =
        messages.value.map((m) {
          if (m.id == id) {
            return m.copy(loadStatus: LoadStatusEnum.failed);
          } else {
            return m;
          }
        }).toList();
    messages.value = msg;
  }

  void updateFileLoadingStatus(String id) {
    final chat = messages.value.firstWhere((msg) => msg.id == id);
    final msg =
        messages.value.map((m) {
          if (m.id == chat.id) {
            return m.copy(loadStatus: LoadStatusEnum.loading);
          } else {
            return m;
          }
        }).toList();
    messages.value = msg;
  }

  void updateFile(ChatMessage chatMsg) {
    final msg =
        messages.value.map((m) {
          if (m.id == chatMsg.id) {
            return chatMsg;
          } else {
            return m;
          }
        }).toList();
    loadingChatIds.remove(chatMsg.id);
    messages.value = msg;
  }

  Future<void> resendImage(String chatId) async {
    final chat = messages.value.firstWhere((msg) => msg.id == chatId);
    final imagePath = chat.data;
    bool isNetwork = imagePath.startsWith('http');
    String? fileUrl;
    updateFileLoadingStatus(chat.id);
    // if (!isNetwork) {
    //   File file = File(imagePath);
    //   final bytes = await file.readAsBytes();
    //   try {
    //     final fileUpload = await pubnub.files.sendFile(
    //       channelName,
    //       'file-${DateTime.now().millisecondsSinceEpoch}',
    //       bytes,
    //     );
    //     if (fileUpload.isError ?? true) {
    //       updateFileFailedStatus(chatId);
    //       return;
    //     }
    //     fileUrl = fileUpload.fileInfo?.url;
    //   } on PubNubException catch (_) {
    //     updateFileFailedStatus(chatId);
    //     return;
    //   }
    // }
    // if (fileUrl != null || isNetwork) {
    //   resendData(chatId);
    // }
  }

  Future<void> resendData(String chatId) async {
    // try {
    //   final chat = messages.value.firstWhere((msg) => msg.id == chatId);
    //   updateFileLoadingStatus(chat.id);
    //   final result = await pubnub.publish(channelName, chat.toJson());
    //   if (result.isError) {
    //     updateFileFailedStatus(chat.id);
    //   }
    // } on PubNubException catch (_) {
    //   updateFileFailedStatus(chatId);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        shadowColor: Colors.black.withOpacity(0.2),
        elevation: 5,
        surfaceTintColor: AppColor.white,
        backgroundColor: AppColor.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Center(
            child: CustomImage(AppSvg.undo, width: 24.r, height: 24.r),
          ),
        ),
        title: AppText.sp18("Back").w700.black,
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: Size(double.maxFinite, 71.h),
          child: Container(
            height: 71.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Container(
                  width: 48.r,
                  height: 48.r,
                  alignment: Alignment.bottomRight,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(AppImage.testAvatar),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child:
                      isUserOnline
                          ? Container(
                            width: 12.r,
                            height: 12.r,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.green,
                            ),
                          )
                          : null,
                ),
                12.horizontalSpace,
                Expanded(
                  child: AppText.sp16(
                    widget.consultation.doctorName,
                  ).w700.setColor(const Color(0xFF071827)),
                ),
                15.horizontalSpace,
                Container(
                  height: 32.h,
                  padding: EdgeInsets.symmetric(horizontal: 10.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: const Color(0xFFF3FFF4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8.r,
                        height: 8.r,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF00A010),
                        ),
                      ),
                      6.horizontalSpace,
                      AppText.sp10(
                        widget.consultation.status,
                      ).w400.setColor(const Color(0xFF1F2937)),
                    ],
                  ),
                ),
                21.horizontalSpace,
                CustomImage(
                  AppSvg.inProgress,
                  width: 19.r,
                  height: 19.r,
                  color: AppColor.green,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: ValueListenableBuilder(
                valueListenable: messages,
                builder: (context, msg, _) {
                  return ListView.separated(
                    reverse: true,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 20.r),
                    itemBuilder: (context, index) {
                      final chatMsg = msg[msg.length - (index + 1)];
                      return ChatMessageWidget(
                        chatMessage: chatMsg,
                        onResend: () {
                          if (chatMsg.type.isImage) {
                            resendImage(chatMsg.id);
                          } else {
                            resendData(chatMsg.id);
                          }
                        },
                        userId: userId,
                      );
                    },
                    separatorBuilder: (context, index) {
                      // check if day is same as previous date then return date object
                      // else return spacer
                      return ChatMessageSeparator(
                        messages: messages.value,
                        index: index,
                      );
                    },
                    itemCount: msg.length,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                InkWell(
                  onTap: _sendImage,
                  child: Container(
                    height: 40.h,
                    width: 40.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF0F2),
                      borderRadius: BorderRadius.circular(11.r),
                    ),
                    child: CustomImage(
                      AppSvg.folder,
                      width: 16.r,
                      height: 16.r,
                      color: AppColor.black,
                    ),
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: SizedBox(
                    height: 40.h,
                    child: TextField(
                      controller: textController,
                      style: TextStyle(
                        fontSize: 12.sp,
                        height: 1,
                        color: AppColor.black,
                      ),
                      onSubmitted: (msg) {
                        _sendMessage(msg);
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10.r),
                        hintText: 'Message',
                        hintStyle: TextStyle(
                          fontSize: 12.sp,
                          height: 1,
                          color: AppColor.lightGrey,
                        ),
                        border: _borderStyle(),
                        focusedBorder: _borderStyle(),
                        enabledBorder: _borderStyle(),
                        isDense: true,
                        prefixIcon: InkWell(
                          onTap: () {
                            // _sendMessage(textController.text);
                          },
                          child: SizedBox(
                            height: 30.h,
                            width: 30.h,
                            child: const Center(
                              child: CustomImage(AppSvg.smileEmoji),
                            ),
                          ),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            _sendMessage(textController.text);
                          },
                          child: SizedBox(
                            height: 30.h,
                            width: 30.h,
                            child: const Center(
                              child: CustomImage(AppSvg.send),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          10.verticalSpace,
        ],
      ),
    );
  }

  OutlineInputBorder _borderStyle() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(11.r),
      borderSide: const BorderSide(color: AppColor.lightGrey),
    );
  }
}
