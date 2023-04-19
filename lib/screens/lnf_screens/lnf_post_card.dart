import 'dart:math';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uniconnect/models/ChatRoomModel.dart';
import 'package:uniconnect/util/colors.dart';
import 'package:uniconnect/widgets/custom_rect_tween.dart';
import 'package:uniconnect/widgets/hero_dialog_route.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:uniconnect/screens/carpool_feed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uniconnect/models/FirebaseHelper.dart';
import 'package:uniconnect/models/UserModel.dart';
import 'package:uniconnect/screens/chat_home_page.dart';
import 'package:uniconnect/util/slideshow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniconnect/providers/providers.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/rendering.dart';
// import 'package:uniconnect/responsive/mobile_screen_layout.dart';
import 'package:uniconnect/screens/NavBar.dart';
// import 'package:uniconnect/models/user.dart' as model;
// import 'package:uniconnect/screens/carpool_upload_post.dart';

//import '../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uniconnect/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uniconnect/screens/chat_room_page.dart';
import 'package:uniconnect/models/ChatRoomModel.dart';


import 'package:uniconnect/screens/chat_room_page.dart';
import 'package:uniconnect/models/ChatRoomModel.dart';

import 'lnfInnerPostCard.dart';


class lnfPostCard extends StatefulWidget {
  final Map<String, dynamic> snap;

  final String hello;
  const lnfPostCard({Key? key, required this.snap, required this.hello}) : super(key: key);

  @override
  _lnfPostCardState createState() => _lnfPostCardState();
}

class _lnfPostCardState extends State<lnfPostCard> {
  String name="name";
  String email="email";
  String phone="phone";
  String hostel="hostel";

  // static late UserModel u1;
  //String imageUrl="https://firebasestorage.googleapis.com/v0/b/uniconnect-62628.appspot.com/o/default_prof.jpg?alt=media&token=2488a918-e680-4445-a04b-5627c62dcf46";
  late String imageUrl;
  final storage=firebase_storage.FirebaseStorage.instance;
  @override
  void initState(){
    super.initState();
    List<String>?PostImages=[];
    setState(() {
      PostImages=getPic();
      imageUrl = PostImages![0];
      print(imageUrl);
    });
    getUserDetails(widget.snap['uid']);

  }

  List<String>? getPic() {
    List<dynamic> dynamicList = widget.snap['pic'];
    List<String>? stringList = dynamicList?.map((item) => item.toString())?.toList();
    return stringList;
  }

  Future<void> getUserDetails(String uid)  async {
    //String uid= FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if(userSnapshot.exists){
      setState(() {
        name= userSnapshot['username'];
        email=userSnapshot['email'];
        hostel=userSnapshot['hostel'];
        phone=userSnapshot["phone"];

      });
    }
  }

  Future<void> getProfilePicture(String postId) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child('buysell%2F$postId%2B1.jpg');

    String url = await ref.getDownloadURL();

    setState(() {
      print("Urlllllllllll= $url");
      imageUrl = url;
    });
  }


  String getHello()
  {
    return widget.hello;
  }

  @override
  Widget build(BuildContext context) {

    // _isProcessing=false;
    // _isProcessing2=false;
    // @override
    // void initState(){
    // super.initState();

    // }




    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(HeroDialogRoute(builder: (context){
          List<dynamic> dynamicList = widget.snap['pic'];
          List<String> stringList = dynamicList.map((e) => e.toString()).toList();

          return lnfInnerPostCard(key: UniqueKey(), hello: getHello(),snap:widget.snap, username: name,pdtDesc: widget.snap['pdtDesc'],pdtName: widget.snap['pdtName'],email: email,images: stringList,uid: widget.snap['uid'],);
        }, settings:const RouteSettings(name: "add_popup_card")));
      },
      child: Hero(
        tag: widget.hello,
        createRectTween: (begin,end){
          return CustomRectTween(begin: begin!,end: end!);
        },
        child:Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Row(
                  children: [
                    // CircleAvatar(
                    //   radius: 22,
                    //   backgroundImage: NetworkImage(
                    //       profile ?? ''),
                    // ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          // child: ClipOval(
                          //   child: FadeInImage.assetNetwork(
                          //     placeholder: 'assets/prof_pic3.jpg',
                          //     //image: imageUrl ?? "https://firebasestorage.googleapis.com/v0/b/uniconnect-62628.appspot.com/o/default_prof.jpg?alt=media&token=2488a918-e680-4445-a04b-5627c62dcf46",
                          //     image: "https://firebasestorage.googleapis.com/v0/b/uniconnect-62628.appspot.com/o/buysell%2F${widget.snap}%2B1.jpg?alt=media&token=05c1abc5-493c-439d-96f3-b17fd1318a63",
                          //     fit: BoxFit.cover,
                          //     imageErrorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                          //       return Image.asset('assets/loading.gif',
                          //           fit: BoxFit.cover
                          //       );
                          //     },
                          //   ),
                          // ),
                          child: Image(image: NetworkImage(imageUrl),fit:BoxFit.cover,),
                        ),SizedBox(width: 19),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.snap['pdtName']?? '',
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.snap['pdtDesc'].substring(0,1)+"...",
                              style: const TextStyle(fontSize: 12, color: mobileSearchColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),SizedBox(height: 9),

                          ],
                        ),
                      ],
                    ),

                  ],
                ),
              ),

              // BODY SECTION BEGINS
              Card(
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(15),
                // ),
                // elevation: 0,
                // color: Colors.white,
                // child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Flex(
                //       direction: Axis.horizontal,
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Expanded(
                //           child: Padding(
                //             padding: const EdgeInsets.only(left:28.0,top: 15),
                //             child: Text(
                //               '${widget.snap['start']} \u27A4 ${widget.snap['destination']}',
                //               style: const TextStyle(
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 15,
                //               ),
                //             ),
                //           ),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.only(right: 30,bottom: 20),
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //               Text(
                //                 '${widget.snap['vehicle'] ?? ''}',
                //                 style: const TextStyle(fontWeight: FontWeight.bold),
                //               ),
                //               const SizedBox(height: 8),
                //               Text(
                //                 '${widget.snap['expectedPerHeadCharge'] ?? ''}',
                //                 style: const TextStyle(fontWeight: FontWeight.bold),
                //               ),
                //               const SizedBox(height: 8),
                //               Text(
                //                 '${(widget.snap['timeOfDeparture'] as Timestamp).toDate().day} ${_getMonth((widget.snap['timeOfDeparture'] as Timestamp).toDate().month)} ${(widget.snap['timeOfDeparture'] as Timestamp).toDate().year}, ${_formatTime((widget.snap['timeOfDeparture'] as Timestamp).toDate())}',
                //                 style: const TextStyle(fontWeight: FontWeight.bold),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}


void setUpChat(String uid){

}

String _formatTime(DateTime dateTime) {
  final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
  final minute = dateTime.minute.toString().padLeft(2, '0');
  final period = dateTime.hour < 12 ? 'am' : 'pm';
  return '$hour:$minute $period';
}