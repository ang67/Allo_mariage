import 'package:allo_mariage/views/widgets/search/Data_search.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchField extends StatefulWidget {
  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  Future<void> _showSearch() async {
    final searchText = await showSearch<String>(
      context: context,
      delegate: DataSearch(
        onSearchChanged: _getRecentSearchesLike,
      ),
    );

    //Save the searchText to SharedPref so that next time you can use them as recent searches.
    await _saveToRecentSearches(searchText);

    //Do something with searchText. Note: This is not a result.
  }

  Future<List<String>> _getRecentSearchesLike(String query) async {
    final pref = await SharedPreferences.getInstance();
    final allSearches = pref.getStringList("recentSearches") ?? [];
    return allSearches.where((search) => search.startsWith(query)).toList();
  }

  Future<void> _saveToRecentSearches(String searchText) async {
    if (searchText == null) return; //Should not be null
    final pref = await SharedPreferences.getInstance();

    //Use `Set` to avoid duplication of recentSearches
    Set<String> allSearches =
        pref.getStringList("recentSearches")?.toSet() ?? {};

    //Place it at first in the set
    allSearches = {searchText, ...allSearches};
    pref.setStringList("recentSearches", allSearches.toList());
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        child: Form(
          key: _formKey,
          child: TextFormField(
              style: TextStyle(color: Colors.black, fontSize: 16.0),
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
                  suffixIcon: Material(
                      elevation: 1.0,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                      )),
                  border: InputBorder.none,
                  hintText: "Recherche prestation de service..."),
              onTap: () {
                _showSearch();
              }),
        ),
      ),
    );
  }
}
