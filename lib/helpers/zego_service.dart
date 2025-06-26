import 'package:flutter/material.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class ZegoService{

  final int appId;
  final String appSign;
  final GlobalKey<NavigatorState> navigatorKey;
  ZegoService({required this.appId, required this.appSign, required this.navigatorKey});

  Future<void> initZego()async{
    ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
    await ZegoUIKit().initLog();
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );
  }

  Future<void> onUserLogin({
    required String currentUserId,
    required String currentUserName,
    Duration? callDuration,
    bool isSmallViewDraggable = true,
    bool switchLargeOrSmallViewByClick = true,
    void Function(ZegoCallEndEvent, void Function())? onCallEnd,
    Future<bool> Function(ZegoCallHangUpConfirmationEvent, Future<bool> Function())? onHangUpConfirmation,
    dynamic Function(ZegoUIKitError)? onError,
    bool addChatButton = false,
    dynamic Function()? onIncomingCallAcceptButtonPressed,
    dynamic Function()? onIncomingCallDeclineButtonPressed,
    dynamic Function(String, ZegoCallUser, String)? onIncomingCallCanceled,
    dynamic Function(String, ZegoCallUser, ZegoCallInvitationType, List<ZegoCallUser>, String)? onIncomingCallReceived,
    Future<void> Function(String, ZegoCallUser, ZegoCallInvitationType, List<ZegoCallUser>, String, Future<void> Function())? onIncomingMissedCallClicked,
    dynamic Function()? onIncomingMissedCallDialBackFailed
  })async{
    await ZegoUIKitPrebuiltCallInvitationService().init(
      appID: appId,
      appSign: appSign,
      userID: currentUserId,
      userName: currentUserName,
      plugins: [ZegoUIKitSignalingPlugin()],
      invitationEvents: ZegoUIKitPrebuiltCallInvitationEvents(
        onIncomingCallAcceptButtonPressed: onIncomingCallAcceptButtonPressed,
        onIncomingCallDeclineButtonPressed: onIncomingCallDeclineButtonPressed,
        onIncomingCallCanceled: onIncomingCallCanceled,
        onIncomingCallReceived: onIncomingCallReceived,
        onIncomingMissedCallClicked: onIncomingMissedCallClicked,
        onIncomingMissedCallDialBackFailed: onIncomingMissedCallDialBackFailed
      ),
      config: ZegoCallInvitationConfig(
        missedCall: ZegoCallInvitationMissedCallConfig(
          enabled: true,
          enableDialBack: true,
        )
      ),
      events: ZegoUIKitPrebuiltCallEvents(
        onCallEnd: onCallEnd,
        onHangUpConfirmation: onHangUpConfirmation,
        onError: onError
      ),
      requireConfig: (data) {
        var config = (data.invitees.length > 1)
            ? ZegoCallType.videoCall == data.type
            ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
            : ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
            : ZegoCallType.videoCall == data.type
            ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
            : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

        config.duration.isVisible = true;
        if(callDuration != null){
          config.duration.onDurationUpdate = (Duration duration) {
            if (duration.inSeconds == callDuration.inSeconds) {
              ZegoUIKitPrebuiltCallController().hangUp(navigatorKey.currentState!.context);
            }
          };
        }

        config.layout = ZegoLayout.pictureInPicture(
          isSmallViewDraggable: isSmallViewDraggable,
          switchLargeOrSmallViewByClick: switchLargeOrSmallViewByClick,
        );
        if(addChatButton){
          config.bottomMenuBarConfig.buttons.add(ZegoCallMenuBarButtonName.chatButton);
        }
        return config;
      },
    );
  }

  Future<void> onUserLogout() async{
   await ZegoUIKitPrebuiltCallInvitationService().uninit();
  }

  Widget zegoButton({
    bool isVideoCall = false,
    required List<ZegoUIKitUser> invites,
}) => ZegoSendCallInvitationButton(
    isVideoCall: true,
    //You need to use the resourceID that you created in the subsequent steps.
    //Please continue reading this document.
    resourceID: "zegouikit_call",
    invitees: invites,
  );
}
