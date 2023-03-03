import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nftapp/controllers/idea_controller.dart';
import 'package:provider/provider.dart';

import 'new_idea_screen.dart';

class IdeaScreen extends StatefulWidget {
  @override
  _IdeaScreenState createState() => _IdeaScreenState();
}

class _IdeaScreenState extends State<IdeaScreen> {
  bool isLoading = true;

  @override
  void initState() {
    getAllIdea();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isLoading = Provider.of<IdeaController>(context, listen: true).isLoading;
    return Scaffold(
      /// ------------ appbar ------------
      appBar: AppBar(title: Text("ideas"), actions: [
        GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewIdeaScreen(),
                  ));
            },
            child: Icon(Icons.add)),
      ]),
      body: Consumer<IdeaController>(
        builder: (context, value, child) {
          return isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.idea.length,
                      itemBuilder: (context, index) {
                        // ------------- ideas section -----------
                        return Center(
                          child: GestureDetector(
                              onTap: () {
                                value.idea[index].likedUser.contains(
                                        FirebaseAuth.instance.currentUser!.uid)
                                    ? value.removeLike(value.idea[index].id)
                                    : value.addLike(value.idea[index].id);
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Text(value.idea[index].title.toString()),
                                    Text(value.idea[index].likedUser.length
                                        .toString()),
                                  ],
                                ),
                              )),
                        );
                      }),
                );
        },
      ),
    );
  }

  // --------------- get ideas from server ------------
  getAllIdea() async {
    await Provider.of<IdeaController>(context, listen: false)
        .GetIdeaController();
  }
}
