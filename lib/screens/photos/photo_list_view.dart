import 'package:flutter/material.dart';
import 'package:flutter_app/data/photo.dart';
import 'package:flutter_app/localizations.dart';
import 'package:flutter_app/screens/photos/contract.dart';
import 'package:flutter_app/screens/photos/presenter.dart';
import 'package:flutter_app/screens/photos/view_item_photo.dart';
import 'package:flutter_app/utils/constants.dart' as Constants;

class PhotoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new PhotoListState();
}

class PhotoListState extends State<PhotoList> implements PhotoListView {
  PhotoListPresenter presenter;

  List<Photo> contactList;
  ScrollController scrollController = new ScrollController();
  TextEditingController searchQuery;

  bool isLoading;
  bool isInit;
  bool isSearchingMode;
  bool isRefresh;

  PhotoListState() {
    presenter = new PhotoPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    searchQuery = new TextEditingController();

    isInit = true;
    isLoading = true;
    isSearchingMode = false;
    isRefresh = true;

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        isLoading = true;
        presenter.loadPhotos(false);
      }
    });
    presenter.loadPhotos(isInit);
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    if (isInit) {
      widget = new Center(
          child: new Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: new CircularProgressIndicator()));
    } else {
      widget = new Scaffold(
          appBar: AppBar(
            title: isSearchingMode
                ? buildSearchField()
                : Text(AppLocalizations.of(context)
                    .trans(Constants.Localization.PHOTOS)),
            actions: buildActions(),
          ),
          body: RefreshIndicator(
              child: GridView.count(
                crossAxisCount: 2,
                controller: scrollController,
                children: List.generate(contactList.length + 1, (index) {
                  return index == contactList.length
                      ? buildProgressIndicator()
                      : buildItem(index);
                }),
              ),
              onRefresh: refresh));
    }
    return widget;
  }

  Widget buildSearchField() {
    return TextField(
      controller: searchQuery,
      autofocus: true,
      decoration: new InputDecoration(
        hintText:
            AppLocalizations.of(context).trans(Constants.Localization.SEARCH),
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.white30),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onSubmitted: (query) {
        isSearchingMode = true;
        isRefresh = true;
        presenter.setQuery(query);
      },
    );
  }

  List<Widget> buildActions() {
    if (isSearchingMode) {
      return <Widget>[
        new IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              setState(() {
                searchQuery.clear();
                isSearchingMode = false;
                isRefresh = true;
                presenter.setQuery(null);
              });
            })
      ];
    } else {
      return <Widget>[
        new IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                isSearchingMode = true;
              });
            })
      ];
    }
  }

  PhotoListItem buildItem(int index) {
    return PhotoListItem(contactList[index]);
  }

  @override
  void onLoadComplete(List<Photo> items) {
    setState(() {
      if (items.isEmpty) {
        /** TODO: get default height
         *  'ProgressIndicator()'*/
        double edge = 56.0;
        double offsetBottom = scrollController.position.maxScrollExtent -
            scrollController.position.pixels;
        if (offsetBottom < edge) {
          scrollController.animateTo(
              scrollController.offset - (edge - offsetBottom),
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOut);
        }
      }
      isRefresh ? contactList = items : contactList.addAll(items);
      isLoading = false;
      isInit = false;
      isRefresh = false;
    });
  }

  @override
  void onLoadError() {
    print("ERROR");
  }

  Widget buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: !isLoading ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future<Null> refresh() async {
    isLoading = true;
    isInit = true;
    isRefresh = true;
    presenter.loadPhotos(isInit);
    return null;
  }
}
