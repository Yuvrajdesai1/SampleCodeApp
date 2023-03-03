import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:nftapp/model/idea_model.dart';
import 'package:nftapp/services/idea_service.dart';

import '../repository/idea_repo.dart';

class IdeaController extends IdeaRepo with ChangeNotifier {
  IdeaService _ideaService = IdeaService();
  List<Idea> idea = [];
  bool isLoading = true;

  // ------------- get idea controller -------------
  @override
  GetIdeaController() {
    idea.clear();
    isLoading = true;
    _ideaService.getIdea().then((value) {
      idea = value;
      notifyListeners();
      isLoading = false;
    });
  }

  // --------------- set idea controller --------------
  @override
  Future SetIdeaController(Idea idea) async {
    isLoading = true;
    _ideaService.setIdea(idea);
    isLoading = false;
    GetIdeaController();
  }

  // ----------- add lik controller -------------------
  @override
  addLike(ideaId) async {
    await _ideaService.addLike(ideaId).then((value) => GetIdeaController());
  }

  // ----------- remove like controller ----------------
  @override
  removeLike(ideaId) async {
    await _ideaService.removeLike(ideaId).then((value) => GetIdeaController());
  }
}
