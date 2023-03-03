import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nftapp/controllers/idea_controller.dart';
import 'package:nftapp/model/idea_model.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class NewIdeaScreen extends StatefulWidget {
  const NewIdeaScreen({Key? key}) : super(key: key);

  @override
  _NewIdeaScreenState createState() => _NewIdeaScreenState();
}

class _NewIdeaScreenState extends State<NewIdeaScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// ------------ appbar ----------
      appBar: AppBar(title: Text("add idea")),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            // ---------- idea title section -------------
            TextFormField(
              controller: _titleController,
            ),
            // ---------- idea description section -------------

            TextFormField(
              controller: _descriptionController,
            ),

            // --------- save button ----------
            GestureDetector(
              onTap: () async {
                String ideaId = uuid.v1().toString();
                Idea idea = await Idea(
                    title: _titleController.text, id: ideaId, likedUser: []);
                idea.likedUser.add(FirebaseAuth.instance.currentUser!.uid);
                Provider.of<IdeaController>(context, listen: false)
                    .SetIdeaController(idea);
                Navigator.pop(context);
              },
              child: Container(
                child: Text("Save"),
                color: Colors.blue,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
