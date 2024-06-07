import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PusherServices{
  static final PusherServices instance = PusherServices._internal();
  PusherServices._internal();

  final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  final notificationsChannelName = "notification";

  static const jobsEventName = "job.create";
  static const courseEventName = "course.create";
  static const servicesEventName = "service.create";

  static const connected = "CONNECTED";
  static const disconnected = "DISCONNECTED";

  void initilizePusher(context) async{
    try{
      await pusher.init(apiKey: "5fbb312480fe6ca175c1", cluster: "eu");

      onNotificationsChannel(context);
    }
    catch(e,s){
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

  Future<void> disconnectPusher() async {
    if(pusher.connectionState == connected){
      try{
        await pusher.unsubscribe(channelName: notificationsChannelName);
        await pusher.disconnect();
      }
      catch(e,s){
        debugPrint("e: ${e.toString()}");
        debugPrint("s: ${s.toString()}");
      }
    }
  }

  Future<void> reinitilizePusher(context) async {
    await disconnectPusher();
    initilizePusher(context);
  }

  onNotificationsChannel(context) async{
    await pusher.subscribe(
        channelName: notificationsChannelName,
        onEvent: (event){
          onNotificationsChannelEvent(context, event);
          return event;
        },
    );

    await pusher.connect();
  }

  void onNotificationsChannelEvent(context, event){
    switch (event.eventName){
      case jobsEventName:
        storeNotification(
            title: "New Job!", data: event.data);
        print(event);
      case courseEventName:
        storeNotification(
            title: "New Course!", data: event.data);
        print(event);
      case servicesEventName:
        storeNotification(
            title: "New Service!", data: event.data);
        print(event);
    }
  }

  Future<void> storeNotification({required String title,required String data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString('notifications') ?? '[]';
    List<Map<String, dynamic>> myList = List<Map<String, dynamic>>.from(jsonDecode(jsonString));
     String m_body = jsonDecode(data)["message"].toString();
    myList.add({
      "title":title,
      "body" : m_body,
    });
    jsonString = jsonEncode(myList);
    await prefs.setString('notifications', jsonString);
  }
}
