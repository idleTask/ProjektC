import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:m0ments/src/blocs/cardList_bloc.dart';
import 'package:m0ments/src/blocs/m0mentCard_bloc.dart';
import 'package:m0ments/src/blocs/profile_bloc.dart';
import 'package:m0ments/src/models/m0mentCard_model.dart';
import 'package:m0ments/src/resources/interfaceData.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m0ments/src/resources/network_data.dart';
import 'package:path/path.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class AddCardPage extends StatefulWidget {
  AddCardPageState createState() => AddCardPageState();
}

class AddCardPageState extends State<AddCardPage> {
  InterfaceData _interfaceData = new InterfaceData();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  File galleryFile;
  File cameraFile;
  List<int> galleryFileBytes;

  Widget build(BuildContext context) {
    NetworkData networkData = NetworkData();
    CardListBloc _clBloc = BlocProvider.of<CardListBloc>(context);
    M0mentCardBloc _bloc = new M0mentCardBloc();
    ProfileBloc _profileBloc = BlocProvider.of<ProfileBloc>(context);

    void _uploadFailedAlert() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            backgroundColor: _interfaceData.getAppBarBackgroundColor(),
            title: new Text(
              "Upload failed",
              style: TextStyle(
                  color: _interfaceData.getContainerColor(), fontSize: 18),
            ),
            content: new Text(
              "Please check your internet connection and try again.",
              style: TextStyle(
                  color: _interfaceData.getContainerColor(), fontSize: 18),
            ),
            actions: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30.0, 10, 30.0, 10),
                      child: RaisedButton(
                        elevation: 0,
                        highlightElevation: 0,
                        color: _interfaceData.getAppBarBackgroundColor(),
                        highlightColor: Theme.of(context).highlightColor,
                        shape: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: _interfaceData.getAppBarTextColor(),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(26.0, 16, 26.0, 16),
                          child: Text(
                            "Ok",
                            style: TextStyle(
                                color: _interfaceData.getContainerColor(),
                                fontSize: 18),
                          ),
                        ),
                      ),
                    )
                  ]),
            ],
          );
        },
      );
    }

    Dio dio = new Dio();
    dio.options.headers =
        networkData.getAuthHeader(_profileBloc.currentState.token);

    FormData formdata = new FormData();

    //Upload mit dio
    Future addItem() async {
      formdata.add("title", titleController.text);
      formdata.add("description", descriptionController.text);
      formdata.add(
          "itemImage", UploadFileInfo(galleryFile, basename(galleryFile.path), contentType: ContentType('image', 'jpeg')));
      print(galleryFile.path);
      dio
          .post(networkData.serverAdress + "items",
              data: formdata,
              options: Options(
                  headers: networkData.getAuthHeaderApplicationJson(
                      _profileBloc.currentState.token),
                  method: 'POST',
                  responseType: ResponseType.json // or ResponseType.JSON
                  ))
          .then((response) {
        return FileBack.fromJson(json.decode(response.data));
      }).catchError((error) => _uploadFailedAlert());
    }

    var appBar = AppBar(
      title: Text(
        "Add Card",
        style: TextStyle(color: _interfaceData.getAppBarTextColor()),
      ),
      backgroundColor: _interfaceData.getAppBarBackgroundColor(),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: _interfaceData.getAppBarTextColor(),
            onPressed: () {
              Navigator.pop(context);
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
    );

    var floatingActionButton = Padding(
        padding: EdgeInsets.all(8),
        child: BlocBuilder(
          bloc: _bloc,
          builder: (context, M0mentCard state) {
            return FloatingActionButton.extended(
              onPressed: () {
                /*
                  print(_clBloc.currentState.cardList.length);
                  state.id = _bloc.currentState.id;
                  state.descr = descriptionController.text;
                  state.title = titleController.text;
                  _clBloc.onAddCard(_bloc);
                  */
                addItem();
                Navigator.pop(context);
              },
              label: Text("Submit"),
              icon: Icon(Icons.check),
              foregroundColor: _interfaceData.getAppBarTextColor(),
              backgroundColor: _interfaceData.getAppBarBackgroundColor(),
            );
          },
        ));

    var titleInput = Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 30,
              controller: titleController,
              style: TextStyle(fontSize: 17),
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Enter a title.'),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
        ),
      ),
    );

    var descriptionInput = Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 250,
              style: TextStyle(fontSize: 17),
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Describe your Image.'),
              controller: descriptionController,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
        ),
      ),
    );

    Widget displaySelectedFile(File file) {
      return Container(
        child: file == null
            ? Container()
            : Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.file(
                    file,
                    fit: BoxFit.fitWidth,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                ),
              ),
      );
    }

    imageSelectorCamera() async {
      cameraFile = await ImagePicker.pickImage(
        source: ImageSource.camera,
      );
      setState(() {});
    }

    imageSelectorGallery() async {
      galleryFile = await ImagePicker.pickImage(
        source: ImageSource.gallery,
      );

      galleryFileBytes = galleryFile.readAsBytesSync();
      setState(() {});
    }

    var imagePicker = Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: _interfaceData.getAppBarBackgroundColor(),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
                  child: Text(
                    "Open Camera",
                    style: TextStyle(
                      color: _interfaceData.getAppBarTextColor(),
                      fontSize: 17,
                    ),
                  ),
                ),
                onPressed: imageSelectorCamera,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: _interfaceData.getAppBarBackgroundColor(),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
                  child: Text(
                    "Open Galery",
                    style: TextStyle(
                        color: _interfaceData.getAppBarTextColor(),
                        fontSize: 17),
                  ),
                ),
                onPressed: imageSelectorGallery,
              ),
            ),
          ],
        ),
      ),
    );

    var body = Container(
      child: ListView(
        children: <Widget>[
          displaySelectedFile(galleryFile),
          imagePicker,
          titleInput,
          descriptionInput,
        ],
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}

class FileBack {
  final String title;
  final String description;
  final File itemImage;

  FileBack({this.title, this.description, this.itemImage});

  factory FileBack.fromJson(Map<String, dynamic> json) {
    return FileBack(
      title: json['title'],
      description: json['description'],
      itemImage: json['itemImage'],
    );
  }
}
