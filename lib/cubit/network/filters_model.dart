class FiltersModels {
  List<ListCategotyFilters>? id = [];

  String? absoluteCommentsFilterMin;
  String? absoluteCommentsFilterMax;

  String? absoluteLikesFilterMin;
  String? absoluteLikesFilterMax;

  String? ermin;
  String? ermax;

  String? numFollowersmin;
  String? numFollowersmax;

  String? date;

  FiltersModels(
      {this.id,
      this.absoluteCommentsFilterMin = "",
      this.absoluteCommentsFilterMax = "",
      this.absoluteLikesFilterMin = "",
      this.absoluteLikesFilterMax = "",
      this.ermin = "",
      this.ermax = "",
      this.numFollowersmin = "",
      this.numFollowersmax = "",
      this.date = ""});

  void clearAll() {
    id = [];
    absoluteCommentsFilterMin = "";
    absoluteCommentsFilterMax = "";
    absoluteLikesFilterMin = "";
    absoluteLikesFilterMax = "";
    ermin = "";
    ermax = "";
    numFollowersmin = "";
    numFollowersmax = "";
    date = "";
  }

  void clearsettings() {
    absoluteCommentsFilterMin = "";
    absoluteCommentsFilterMax = "";
    absoluteLikesFilterMin = "";
    absoluteLikesFilterMax = "";
    ermin = "";
    ermax = "";
    numFollowersmin = "";
    numFollowersmax = "";
    date = "";
  }

  void clearId() {
    id = [];
  }

  List<ListCategotyFilters>? get getterlist => id;
}

class ListCategotyFilters {
  String id;
  String name;
  ListCategotyFilters({this.id = "", this.name = ""});
}
