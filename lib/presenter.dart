import 'contract.dart';
import 'data/photo_data_mock.dart';
import 'data/photo_repository.dart';

class PhotoPresenter extends PhotoListPresenter {
  PhotoListView view;
  PhotoRepository repository;

  PhotoPresenter(this.view) {
    repository = new MockPhotoRepository();
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
