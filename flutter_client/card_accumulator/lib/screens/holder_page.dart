import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HoldersScreen extends StatefulWidget {
  const HoldersScreen({Key? key}) : super(key: key);

  @override
  _HoldersScreenState createState() => _HoldersScreenState();
}

class _HoldersScreenState extends State<HoldersScreen> {
  final _controller = ScrollController();
  ScrollPhysics _physics =
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels <= 56) {
        setState(() => _physics = const BouncingScrollPhysics());
      } else {
        setState(() => _physics = const BouncingScrollPhysics());
      }
    });
  }

  List HolderData = [];
  String QUERY = """
      query{
          holders{
              name
              id
              profession
              age
              }
          }
  """;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(QUERY)),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return const CircularProgressIndicator();
        }
        HolderData = result.data!["holders"];
        return (HolderData.isNotEmpty)
            ? ListView.builder(
                controller: _controller,
                physics: _physics,
                itemCount: HolderData.length,
                itemBuilder: (context, index) {
                  final holder = HolderData[index];
                  return Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            bottom: 23, left: 19, right: 19, top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.purple,
                              Colors.deepPurple,
                              Colors.deepPurple.shade700
                            ],
                          ),
                          // ignore: prefer_const_literals_to_create_immutables
                          boxShadow: [
                            // ignore: prefer_const_constructors
                            BoxShadow(
                              offset: const Offset(2, 8),
                              color: Colors.black,
                              blurRadius: 12,
                            )
                          ],
                        ),
                        padding: const EdgeInsets.all(20),
                        child: InkWell(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${holder["name"]}",
                                      style: GoogleFonts.playfairDisplay(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 36.0),
                                      child: Text(
                                        "Age:${holder["age"] ?? 'N/A'}",
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 1.0, bottom: 12.0),
                                  child: Text(
                                    "Profession:${holder["profession"] ?? 'N/A'}",
                                  ),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.purple,
                                  Colors.deepPurple,
                                  Colors.deepPurple.shade700
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 2.0,
                        left: 120.0,
                        child: RawMaterialButton(
                          padding: EdgeInsets.all(9.0),
                          shape: CircleBorder(),
                          elevation: 14.0,
                          fillColor: Colors.grey.shade900,
                          child: Icon(
                            Icons.edit,
                            color: Colors.green,
                            size: 27.0,
                          ),
                          onPressed: () => print('Add to cart'),
                        ),
                      ),
                      Positioned(
                        bottom: 2.0,
                        left: 190.0,
                        child: RawMaterialButton(
                          padding: EdgeInsets.all(9.0),
                          shape: CircleBorder(),
                          elevation: 14.0,
                          fillColor: Colors.grey.shade900,
                          child: Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                            size: 27.0,
                          ),
                          onPressed: () => print('Add to cart'),
                        ),
                      ),
                    ],
                  );
                },
              )
            // ignore: avoid_unnecessary_containers
            : Container(
                child: Center(
                  child: Text(
                    "No holders found",
                    style: GoogleFonts.openSans(
                        color: Colors.grey.shade200,
                        fontSize: 12,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              );
      },
    );
  }
}
