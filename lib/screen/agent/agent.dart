import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_project/services/provider/agent.dart';
import 'package:real_estate_project/utility/toast/show_message.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:jiffy/jiffy.dart';



import '../../const/const.dart';
import '../../services/auth/auth.dart';
import '../../services/provider/dark_theme.dart';

// ignore: must_be_immutable
class AgentScreen extends StatefulWidget {
  String id;
  String firstName, lastName, email;
  List<dynamic> contact;
  String imgUrl;
  dynamic companyNameForAgent;

  AgentScreen({super.key, 
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contact,
    required this.imgUrl,
    required this.companyNameForAgent,
  });

  @override
  State<AgentScreen> createState() => _AgentScreenState();
}

class _AgentScreenState extends State<AgentScreen> {
  final TextEditingController _commentController = TextEditingController();

  late Future _getComments;
  bool _isInit = true;

  bool _addCommentLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<AgentProvider>(context).clearComments();
      _getComments = Provider.of<AgentProvider>(context, listen: false)
          .getAgentComments(widget.id);
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        title: Text(
          "Property Agent",
          style: appBarStyle(screenSize),
        ),
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 50),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //
                    //Agent Profile
                    //
                    Container(
                      height: screenSize.width * 0.18,
                      width: screenSize.width * 0.18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(widget.imgUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    //
                    //Agent Name
                    //
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.firstName.toUpperCase()} ${widget.lastName.toUpperCase()}",
                          style: TextStyle(
                              fontFamily: AppFonts.semiBold,
                              fontSize: AppTextSize.propertyNameSize),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          widget.companyNameForAgent,
                          style: TextStyle(
                              fontFamily: AppFonts.medium,
                              fontSize: AppTextSize.subTextSize + 1,
                              color: AppColor.thirdColor),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                //
                //Agent Contact
                //
                SizedBox(
                  height: 36,
                  child: ListView.builder(
                      itemCount: widget.contact.length,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: GestureDetector(
                            onTap: () async {
                              try {
                                await launchUrl(
                                  Uri(
                                      scheme: "tel",
                                      path: widget.contact[index]),
                                );
                                // ignore: empty_catches
                              } catch (e) {}
                            },
                            child: Container(
                              width: screenSize.width * 0.42,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColor.primaryColorCustom,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.wifi_calling_3_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Call  ${index + 1}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: screenSize.width * 0.04,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                const SizedBox(height: 25),
                //
                //Comments
                //
                Text(
                  "Comments",
                  style: TextStyle(
                    fontSize: AppTextSize.propertyNameSize,
                    fontFamily: AppFonts.semiBold,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: SizedBox(
                    width: screenSize.width,
                    child: FutureBuilder(
                        future: _getComments,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Consumer<AgentProvider>(
                                builder: (context, comments, _) {
                              if (comments.agentComment.isEmpty) {
                                return Center(
                                    child: Text(
                                  "Be the first one to comment ...",
                                  style: TextStyle(
                                      fontSize: AppTextSize.subTextSize + 3,
                                      color: AppColor.shadeGrey,
                                      fontFamily: AppFonts.medium),
                                ));
                              }
                              return ListView.builder(
                                  itemCount: comments.agentComment.length,
                                  scrollDirection: Axis.vertical,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Stack(children: [
                                      Card(
                                        elevation: 0.05,
                                        margin: const EdgeInsets.only(
                                            top: 8, bottom: 5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        color: Provider.of<DarkThemeProvider>(
                                                    context)
                                                .isDarkMode
                                            ? AppColor.darkBackground
                                            : Colors.white,
                                        child: SizedBox(
                                          height: (comments.agentComment[index]
                                                      .comment.length /
                                                  5) +
                                              110,
                                          width: screenSize.width,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        //
                                                        //Commented User Image
                                                        //
                                                        Container(
                                                          height:
                                                              screenSize.width *
                                                                  0.1,
                                                          width:
                                                              screenSize.width *
                                                                  0.1,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            image:
                                                                DecorationImage(
                                                              image: NetworkImage(
                                                                  comments
                                                                      .agentComment[
                                                                          index]
                                                                      .user
                                                                      .profile),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        //
                                                        //Commented User Name
                                                        //
                                                        Text(
                                                          "${comments.agentComment[index].user.firstName} ${comments.agentComment[index].user.lastName}",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  AppFonts
                                                                      .semiBold,
                                                              fontSize: AppTextSize
                                                                      .propertyNameSize -
                                                                  2),
                                                        ),
                                                        const Spacer(),
                                                        //
                                                        //Delete Message Icon
                                                        //
                                                        if (Provider.of<AuthProvider>(
                                                                    context)
                                                                .userId ==
                                                            comments
                                                                .agentComment[
                                                                    index]
                                                                .user
                                                                .id)
                                                          GestureDetector(
                                                            onTap: () {
                                                              try {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (ctx) {
                                                                      return AlertDialog(
                                                                        title: const Text(
                                                                            'Delete Comment'),
                                                                        content:
                                                                            const Text('Permanently delete your comment?'),
                                                                        actions: [
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.of(context).pop(),
                                                                            child:
                                                                                const Text('CANCEL'),
                                                                          ),
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                              Provider.of<AgentProvider>(context, listen: false).deleteComment(comments.agentComment[index].id, widget.id);
                                                                            },
                                                                            child:
                                                                                const Text('ACCEPT'),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    });
                                                                // ignore: empty_catches
                                                              } catch (e) {}
                                                            },
                                                            child: Icon(
                                                                Icons.delete,
                                                                size: 19,
                                                                color: Colors
                                                                    .red
                                                                    .shade400),
                                                          )
                                                      ]),
                                                ),
                                                //
                                                //User Comment
                                                //
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12, right: 22),
                                                  child: Text(
                                                    comments.agentComment[index]
                                                        .comment,
                                                    maxLines: 3,
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            AppFonts.medium,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        right: 10,
                                        child: Text(
                                          Jiffy(comments.agentComment[index]
                                                  .createdAt)
                                              .fromNow(),
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: AppColor.shadeGrey,
                                              fontSize: 12.5,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      )
                                    ]);
                                  });
                            });
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ),
                ),
              ]),
        ),
        Positioned(
          bottom: 0.0,
          child: Container(
            height: 50,
            width: screenSize.width,
            decoration: BoxDecoration(
              color: Provider.of<DarkThemeProvider>(context).isDarkMode
                  ? AppColor.darkBackground
                  : Colors.white,
            ),
            child: TextField(
              controller: _commentController,
              keyboardType: TextInputType.text,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 10),
                  border: InputBorder.none,
                  hintText: "Add Comment...",
                  hintStyle: TextStyle(
                      fontFamily: AppFonts.regular,
                      fontSize: AppTextSize.subTextSize + 2),
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (_commentController.text.length <= 5) {
                        showErrorMessage(220, context, "Comment to short!");
                      } else {
                        try {
                          String comment = _commentController.text;
                          _commentController.clear();
                          FocusScope.of(context).unfocus();
                          setState(() {
                            _addCommentLoading = true;
                          });
                          Provider.of<AgentProvider>(context, listen: false)
                              .addComment(
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .userId,
                                  widget.id,
                                  comment)
                              .then((_) => setState(() {
                                    _addCommentLoading = false;
                                  }));
                          // ignore: empty_catches
                        } catch (e) {}
                      }
                    },
                    icon: _addCommentLoading
                        ? Transform.scale(
                            scale: 0.7,
                            child: const CircularProgressIndicator())
                        : const Icon(Icons.send),
                  )),
            ),
          ),
        ),
      ]),
    );
    //   bottomNavigationBar: SingleChildScrollView(
    //     child: Container(
    //       height: 50,
    //       child: ,
    //   ),
    // );
  }
}
