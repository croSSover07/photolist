import 'package:flutter/material.dart';
import 'package:flutter_app/data/photo.dart';
import 'package:flutter_app/localizations.dart';
import 'package:flutter_app/net/http_client.dart' as http;
import 'package:flutter_app/utils/constants.dart' as Constants;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_view/photo_view.dart';
import 'package:simple_permissions/simple_permissions.dart';

import 'contract.dart';
import 'presenter.dart';

class PhotoPage extends StatelessWidget {
  final String photoId;

  PhotoPage(this.photoId);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new PhotoPageView(photoId),
    );
  }
}

class PhotoPageView extends StatefulWidget {
  final String photoId;

  PhotoPageView(this.photoId);

  @override
  State createState() => new PhotoPageViewState(photoId);
}

class PhotoPageViewState extends State<PhotoPageView>
    implements PhotoContractView {
  bool isLoad = false;
  PhotoContractPresenter presenter;
  String photoId;
  Photo photo;
  VoidCallback showModalBottomSheetCallback;
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  PhotoPageViewState(this.photoId) {
    presenter = PhotoPageViewPresenter(this);
  }

  @override
  void initState() {
    super.initState();

    showModalBottomSheetCallback = showBottomSheet;
    isLoad = true;
    presenter.loadPhoto();
  }

  @override
  void onLoadError() {}

  @override
  void onLoadComplete(Photo item) {
    setState(() {
      isLoad = false;
      photo = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    if (isLoad) {
      widget = new Center(
          child: new Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: new CircularProgressIndicator()));
    } else {
      widget = new Scaffold(
        key: scaffoldKey,
        body: new PhotoView(
            imageProvider: NetworkImage(photo.url, headers: http.headers)),
        floatingActionButton: new IconButton(
          icon: new Icon(Icons.info_outline),
          onPressed: showModalBottomSheetCallback,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
    }
    return widget;
  }

  void showBottomSheet() {
    List<Widget> list = [];

    photo.instagramName != null
        ? list.add(new ListTile(
            leading: new Text(AppLocalizations.of(context)
                .trans(Constants.Localization.INSTAGRAM)),
            title: new Text(photo.instagramName,
                style: TextStyle(decoration: TextDecoration.underline)),
            onTap: presenter.openInstaProfile,
          ))
        : {};

    list.add(new ListTile(
      leading: new Text(
          AppLocalizations.of(context).trans(Constants.Localization.WIDTH)),
      title: new Text(photo.width.toString()),
    ));

    list.add(new ListTile(
      leading: new Text(
          AppLocalizations.of(context).trans(Constants.Localization.HEIGHT)),
      title: new Text(photo.height.toString()),
    ));

    photo.location != null
        ? list.add(new ListTile(
            leading: new Text(AppLocalizations.of(context)
                .trans(Constants.Localization.LOCATION)),
            title: new Text(photo.location),
          ))
        : {};

    list.add(new ListTile(
      leading: new Text(
          AppLocalizations.of(context).trans(Constants.Localization.DOWNLOADS)),
      title: new Text(photo.downloads.toString()),
    ));

    list.add(new Row(children: <Widget>[
      new Expanded(
          child: new FlatButton.icon(
              onPressed: () {
                checkPermission(presenter.setWallPaper);
              },
              icon: new Icon(Icons.image),
              label: new Text(AppLocalizations.of(context)
                  .trans(Constants.Localization.SET_AS)))),
      new Expanded(
        child: new FlatButton.icon(
            onPressed: () async {
              checkPermission(presenter.downloadPhoto);
            },
            icon: new Icon(Icons.file_download),
            label: new Text(AppLocalizations.of(context)
                .trans(Constants.Localization.DOWNLOAD))),
      )
    ]));

    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Column(mainAxisSize: MainAxisSize.min, children: list);
        });
  }

  void checkPermission(VoidCallback callback) {
    SimplePermissions.checkPermission(Permission.WriteExternalStorage)
        .then((onValue) {
      onValue
          ? callback()
          : SimplePermissions.requestPermission(Permission.WriteExternalStorage)
              .then((permissionStatus) {
              permissionStatus == PermissionStatus.authorized
                  ? callback()
                  : Fluttertoast.showToast(
                      msg: AppLocalizations.of(context)
                          .trans(Constants.Localization.PERMISSION_DENIED));
            });
    });
  }
}
