import 'package:flutter_app/data/photo.dart';

abstract class PhotoListView {
  void onLoadComplete(List<Photo> items);

  void onLoadError();
}

abstract class PhotoListPresenter {
  void loadPhotos(bool isRefresh);
  void setQuery(String query);
}
