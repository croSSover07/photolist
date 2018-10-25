import 'package:flutter_app/data/photo_data.dart';
import 'package:flutter_app/data/photo_repository.dart';
import 'package:flutter_app/photos/contract.dart';

class PhotoPresenter extends PhotoListPresenter {
  PhotoListView view;
  PhotoRepository repository;

  PhotoPresenter(this.view) {
    repository = new ServerPhotoRepository();
  }

  @override
  void loadPhotos() {
    assert(view != null);
    repository
        .fetch()
        .then((photos) => view.onLoadComplete(photos))
        .catchError((onError) {
      print(onError);
      view.onLoadError();
    });
  }
}
