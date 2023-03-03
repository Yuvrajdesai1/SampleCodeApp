import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/idea_model.dart';

class IdeaService {
  List<Idea> data = [];
  Idea? idea;


  // --------- set idea -----------------
  Future setIdea(Idea idea) async {
    await FirebaseFirestore.instance.collection("Ideas").add(idea.toJson());
  }

  // ------------- get idea  ---------------
  Future getIdea() async {
    var response = await FirebaseFirestore.instance
        .collection("Ideas")
        .orderBy("likedUser", descending: true)
        .get();
    response.docs.forEach((element) {
      data.add(Idea.fromJson(element.data()));
    });
    return data;
  }

  // --------------- add like to idea ----------------
  Future addLike(ideaId) async {
    var response = await FirebaseFirestore.instance
        .collection("Ideas")
        .where("id", isEqualTo: ideaId)
        .get();
    response.docs.forEach((element) {
      idea = Idea.fromJson(element.data());
      idea!.likedUser.add(FirebaseAuth.instance.currentUser!.uid);
      FirebaseFirestore.instance
          .collection("Ideas")
          .doc(element.id)
          .set(idea!.toJson(), SetOptions(merge: true));
    });
  }

  // ------------ remove like from idea ----------
  Future removeLike(ideaId) async {
    var response = await FirebaseFirestore.instance
        .collection("Ideas")
        .where("id", isEqualTo: ideaId)
        .get();
    response.docs.forEach((element) {
      idea = Idea.fromJson(element.data());
      idea!.likedUser.remove(FirebaseAuth.instance.currentUser!.uid);
      FirebaseFirestore.instance
          .collection("Ideas")
          .doc(element.id)
          .set(idea!.toJson(), SetOptions(merge: true));
    });
  }
}
