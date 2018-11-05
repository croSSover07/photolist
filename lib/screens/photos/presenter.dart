import 'package:flutter_app/data/photo_data.dart';
import 'package:flutter_app/data/photo_repository.dart';
import 'package:flutter_app/screens/photos/contract.dart';

class PhotoPresenter extends PhotoListPresenter {
  PhotoListView view;
  PhotoRepository repository;

  PhotoPresenter(this.view) {
    repository = new ServerPhotoRepository();
  }

  @override
  void loadPhotos(bool isRefresh) {
    assert(view != null);
    (isRefresh ? repository.init() : repository.loadMore())
        .then((photos) => view.onLoadComplete(photos))
        .catchError((onError) {
      print(onError);
      view.onLoadError();
    });
  }

  @override
  void setQuery(String query) {
    repository.query = query;
    loadPhotos(true);
  }
}
