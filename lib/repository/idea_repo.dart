import '../model/idea_model.dart';

abstract class IdeaRepo {

  // ----------- set idea controller ----------
  SetIdeaController(Idea idea);

  // ------------ get idea controller ----------
  GetIdeaController();

  // ------------ add like controller ----------
  addLike(ideaId);

  // -------------- remove like controller ----------
  removeLike(ideaId);
}