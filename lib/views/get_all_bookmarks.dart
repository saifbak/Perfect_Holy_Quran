import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perfectholyquran/canvaDBFiles/newDBHelper.dart';

class GetAllBookmarks extends StatefulWidget {
  const GetAllBookmarks({Key key}) : super(key: key);

  @override
  _GetAllBookmarksState createState() => _GetAllBookmarksState();
}

class _GetAllBookmarksState extends State<GetAllBookmarks> {
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    void _delete(int id) async {
      // Assuming that the number of rows is the id for the last row.
      // final id = await dbHelper.queryRowCount();
      final rowsDeleted = await dbHelper.delete(id);
      print('deleted $rowsDeleted row(s): row $id');
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff025241),
        title: Text(
          'List Of BookMarks',
        ),
      ),
      body: FutureBuilder<List>(
        future: dbHelper.queryAllRows(),
        initialData: List(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, int position) {
                    final item = snapshot.data[position];
                    //get your item data here ...
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data[position].row[3],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                    onPressed: () {
                                      _delete(snapshot.data[position].row[0]);
                                      // SweetAlert.show(this.context, title: "Delete Bookmark",
                                      //     subtitle: 'Are you sure!', style: SweetAlertStyle.success,
                                      //     onPress: (bool isConfirmed) {
                                      //       if (isConfirmed)
                                      //         _delete(snapshot.data[position].row[0]);
                                      //
                                      //       return false;
                                      //     });
                                    },
                                    icon: Icon(Icons.close)),
                              ],
                            ),
                            Text(
                              snapshot.data[position].row[4],
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
