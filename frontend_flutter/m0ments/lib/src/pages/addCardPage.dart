import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m0ments/src/blocs/cardList_bloc.dart';
import 'package:m0ments/src/blocs/m0mentCard_bloc.dart';
import 'package:m0ments/src/models/m0mentCard_model.dart';
import 'package:m0ments/src/resources/interfaceData.dart';
import 'package:image_picker/image_picker.dart';

class AddCardPage extends StatefulWidget {
  AddCardPageState createState() => AddCardPageState();
}

class AddCardPageState extends State<AddCardPage> {
  InterfaceData _interfaceData = new InterfaceData();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  File galleryFile;
  File cameraFile;

  Widget build(BuildContext context) {
    CardListBloc _clBloc = BlocProvider.of<CardListBloc>(context);
    M0mentCardBloc _bloc = new M0mentCardBloc();

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
                setState(() {
                  print(_clBloc.currentState.cardList.length);
                  state.id = _bloc.currentState.id;
                  state.descr = descriptionController.text;
                  state.title = titleController.text;
                  _clBloc.onAddCard(_bloc);
                  Navigator.pop(context);
                });
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
              onEditingComplete: () {
                setState(() {
                  print(titleController.text);
                });
              },
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
              onEditingComplete: () {
                setState(() {
                  print(descriptionController.text);
                });
              },
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
                  padding: const EdgeInsets.fromLTRB(8.0, 10.0,8.0,10.0),
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
                  padding: const EdgeInsets.fromLTRB(8.0, 10.0,8.0,10.0),
                  child: Text(
                    "Open Galery",
                    style: TextStyle(
                        color: _interfaceData.getAppBarTextColor(), fontSize: 17),
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
