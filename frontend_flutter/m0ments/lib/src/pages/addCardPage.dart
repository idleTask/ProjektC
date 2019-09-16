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

    Dio dio = new Dio();
    dio.options.headers =
        networkData.getAuthHeader(_profileBloc.currentState.token);

    FormData formdata = new FormData();

    //Upload Versuch mit dio
    Future addItem() async {
      formdata.add("title", titleController.text);
      formdata.add("description", descriptionController.text);
      formdata.add(
          "photos", UploadFileInfo(galleryFile, basename(galleryFile.path)));
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
          })
          .catchError((error) => print(error));
    }

    //anderer Upload Versuch
    uploadFileUriMultipartRequest() async {
      var postUri = Uri.parse(networkData.serverAdress + "items");
      var request = new http.MultipartRequest("POST", postUri);
      request.headers
          .addAll(networkData.getAuthHeader(_profileBloc.currentState.token));
      request.fields['title'] = titleController.text;
      request.files.add(new http.MultipartFile.fromBytes(
          'file', await File.fromUri(galleryFile.uri).readAsBytes(),
          contentType: MediaType('image', 'jpeg')));

      request.send().then((response) {
        if (response.statusCode == 200) print("Uploaded!");
      });
    }

    //dritter Versuch
    upload(File imageFile) async {
      print("try upload");
      var stream =
          new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();

      var uri = Uri.parse(networkData.serverAdress + "items");

      var request = new http.MultipartRequest("POST", uri);

      request.headers
          .addAll(networkData.getAuthHeader(_profileBloc.currentState.token));
      var multipartFile = new http.MultipartFile('file', stream, length,
          filename: basename(imageFile.path));
      //contentType: new MediaType('image', 'png'));

      request.files.add(multipartFile);
      var response = await request.send();
      if (response.statusCode == 200) {
        print(response.statusCode);
      } else {
        print(response.statusCode);
        throw Exception();
      }

      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
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
