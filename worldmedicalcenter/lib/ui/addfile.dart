import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';


class AddDocument extends StatefulWidget {
  AddDocument({Key? key}) : super(key: key);

  @override
  State<AddDocument> createState() => _AddDocumentState();
}

class _AddDocumentState extends State<AddDocument> {
Future<void> openFile() async{
    FilePickerResult? resultfile = await FilePicker.platform.pickFiles();
    if(resultfile!=null){
      PlatformFile file = resultfile.files.first;

    print(file.name);
    print(file.bytes);
    print(file.size);
    print(file.extension);
    print(file.path);

    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(children: [
        Container(
          child: GestureDetector(
            onTap: (){
              openFile();
            },
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Text('upload file'),
            ),
          ),
        )
      ]),
    );
}
}