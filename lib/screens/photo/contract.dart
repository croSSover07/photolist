import 'package:flutter_app/data/photo.dart';

abstract class PhotoContractView {
  String photoId;
  void onLoadComplete(Photo item);
  void onLoadError();
}

abstract class PhotoContractPresenter {
  void loadPhoto();
  void downloadPhoto();
  void setWallPaper();
  void openInstaProfile();
}