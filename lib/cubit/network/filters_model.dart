class FiltersModels {
  List<ListCategotyFilters>? id = [];

  String? absoluteCommentsFilterMin;
  String? absoluteCommentsFilterMax;

  String? absoluteLikesFilterMin;
  String? absoluteLikesFilterMax;

  String? ermin;
  String? ermax;

  FiltersModels(
      {this.id,
      this.absoluteCommentsFilterMin = "",
      this.absoluteCommentsFilterMax = "",
      this.absoluteLikesFilterMin = "",
      this.absoluteLikesFilterMax = "",
      this.ermin = "",
      this.ermax = ""});

  void clearAll() {
    id = [];
    absoluteCommentsFilterMin = "";
    absoluteCommentsFilterMax = "";
    absoluteLikesFilterMin = "";
    absoluteLikesFilterMax = "";
    ermin = "";
    ermax = "";
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
