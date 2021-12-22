class FiltersModels {
<<<<<<< HEAD
  List<ListCategotyFilters>? id = [];
=======
  List<String?>? id = [];
>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf

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
<<<<<<< HEAD

  void clearId() {
    id = [];
  }

  List<ListCategotyFilters>? get getterlist => id;
}

class ListCategotyFilters {
  String id;
  String name;
  ListCategotyFilters({this.id = "", this.name = ""});
=======
>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf
}
