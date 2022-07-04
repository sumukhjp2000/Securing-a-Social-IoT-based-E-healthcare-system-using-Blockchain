import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart';
import 'package:health_tracker/components.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';

class ReportsScreenWidget extends StatefulWidget {
  const ReportsScreenWidget({Key? key}) : super(key: key);
  static String id = '/reports';
  @override
  _ReportsScreenWidgetState createState() => _ReportsScreenWidgetState();
}

class _ReportsScreenWidgetState extends State<ReportsScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  UploadTask? task;
  File? file;
  List<Document> documents = [];

  // Stream<ListResult> listAllPaginated(Reference StorageRef) async* {
  //   String? pageToken;
  //   do {
  //     final listResult = await StorageRef.list(ListOptions(
  //       maxResults: 100,
  //       pageToken: pageToken,
  //     ));
  //     yield listResult;
  //     pageToken = listResult.nextPageToken;
  //   } while (pageToken != null);
  // }
  void initState(){
    super.initState();

    listExample();
  }
  Future<void> listExample() async {
    final StorageRef = await FirebaseStorage.instance.ref().child("files/");
    final listResult = await StorageRef.listAll();
    print('item');
    documents.clear();

    for (var item in listResult.items) {
      print(await item.getDownloadURL());
      documents.add(Document(title: item.name, url: await item.getDownloadURL()));
    }
    setState(() {
    });
  }
  void _launchUrl(String url) async {
    Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }
  Future<void>?_launched;
  String _phone = '';

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }
  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
    stream: task.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final snap = snapshot.data!;
        final progress = snap.bytesTransferred / snap.totalBytes;
        final percentage = (progress * 100).toStringAsFixed(2);

        return Text(
          '$percentage %',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        );
      } else {
        return Container();
      }
    },
  );

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? 'File Selected!' : 'Select File';
    return RefreshIndicator(
      onRefresh: listExample,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Health Reports',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.teal,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical:18.0, horizontal:18.0 ),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white60,
                          border: Border.all(color: Colors.black, width: 5),
                          borderRadius: BorderRadius.circular(10.0,),
                        ),
                      child: ListView.builder(itemBuilder:(context, index) {
                          return ElevatedButton(
                            onPressed: ()async {
                              openFile(
                                url:documents[index].url,
                                fileName: fileName,
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white60),
                            ),
                            child: ListTile(
                              title: Text(documents[index].title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                decoration: TextDecoration.underline,
                              ),
                              ),
                              trailing: InkWell(
                                onTap: (){
                                  print("index ${index}");
                                },
                                child: IconButton(
                                  icon: Icon(Icons.download),
                                  onPressed: () async {
                                    //TODO:Url Launcher
                                    // _launchUrl(documents[index].url);
                                    openFile(
                                      url:documents[index].url,
                                      fileName: fileName,
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                      },
                      itemCount: documents.length
                      ) )
                    ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (LoginPressed.loginvalue==5)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(fileName,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed:() async{
                                      final result = await FilePicker.platform.pickFiles(allowMultiple: false);
                                      if(result==null) return;
                                      final path =  result.files.single.path!;
                                      // print('Path: ${file.path}');
                                      setState(() => file = File(path));

                                      // final newFile =await saveFilePermanently(file);
                                      // print('New Path: ${newFile.path}');
                                      // openFile(file);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.teal),
                                    ),
                                    child: Text('SELECT',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white
                                      ),
                                    )
                                ),
                              ],
                            ),
                            Column(
                              children: [

                                task != null ? buildUploadStatus(task!) :SizedBox(height: 20,),
                                ElevatedButton(
                                    onPressed:() {
                                     uploadFile();
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.teal),
                                    ),
                                    child: Text('UPLOAD',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white
                                      ),
                                    )
                                ),

                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,

                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


Future openFile({required String url, String? fileName})async{
    final file = await downloadFile(url, fileName!);
    if (file == null) return;
    OpenFile.open(file.path);
}

Future<File?> downloadFile(String url, String name)async{
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');
    final response = await Dio().get(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
        receiveTimeout: 0
      )
    );
    final raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();
    return file;
}



class Document{
  String title;
  String url;
  Document({required this.title, required this.url});
}