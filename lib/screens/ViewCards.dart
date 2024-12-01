import 'package:firebase/screens/editcard.dart';
import 'package:firebase/services/firestoreservice.dart';
import 'package:flutter/material.dart';

import '../models/model.dart';

class ViewCards extends StatefulWidget {
  const ViewCards({super.key});

  @override
  State<ViewCards> createState() => _ViewCardsState();
}

class _ViewCardsState extends State<ViewCards> {
  final FirestoreService _firestoreService = FirestoreService();
  List<BusinessCard> _filteredCards = [];
  String _selectedSort = 'Name'; // Default sort option
  String? _selectedFilter; // Current selected filter option (nullable)
  Set<String> _uniqueCompanies = {}; // Stores unique company names for filtering

  @override
  void initState() {
    super.initState();
    _fetchCards();
  }

  // Fetch cards and populate unique companies for filtering
  Future<void> _fetchCards() async {
    final cards = await _firestoreService.getAllCards();
    setState(() {
      _filteredCards = cards;
      _uniqueCompanies = cards.map((card) => card.company).toSet(); // Extract unique companies
      _applySorting(); // Apply default sorting
    });
  }

  // Sorting logic based on selected criteria
  void _applySorting() {
    setState(() {
      if (_selectedSort == 'Name') {
        _filteredCards.sort((a, b) => a.name.compareTo(b.name));
      } else if (_selectedSort == 'Job Title') {
        _filteredCards.sort((a, b) => a.jobTitle.compareTo(b.jobTitle));
      } else if (_selectedSort == 'Company') {
        _filteredCards.sort((a, b) => a.company.compareTo(b.company));
      }
    });
  }

  // Filtering logic to show cards based on the selected company
  void _applyFilter() {
    setState(() {
      if (_selectedFilter == null || _selectedFilter!.isEmpty) {
        _fetchCards(); // Reset to all cards if no filter is selected
      } else {
        _filteredCards = _filteredCards.where((card) {
          return card.company.toLowerCase() == _selectedFilter!.toLowerCase();
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Cards"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Dropdown for Sorting
                DropdownButton<String>(
                  value: _selectedSort,
                  onChanged: (value) {
                    setState(() {
                      _selectedSort = value!;
                      _applySorting(); // Apply sorting on change
                    });
                  },
                  items: ['Name', 'Job Title', 'Company']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text('Sort by $value'),
                    );
                  }).toList(),
                ),

                // Dropdown for Filtering by Company
                DropdownButton<String?>(
                  value: _selectedFilter,
                  hint: const Text("Filter by Company"),
                  onChanged: (value) {
                    setState(() {
                      _selectedFilter = value;
                      _applyFilter();
                    });
                  },
                  items: [
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: Text('All Companies'),
                    ),
                    ..._uniqueCompanies.map((company) {
                      return DropdownMenuItem<String?>(
                        value: company,
                        child: Text(company),
                      );
                    }).toList(),
                  ],
                ),
              ],
            ),
          ),

          // List of Cards
          Expanded(
            child: _filteredCards.isEmpty
                ? const Center(child: Text("No cards available."))
                : ListView.builder(
              itemCount: _filteredCards.length,
              itemBuilder: (context, index) {
                final card = _filteredCards[index];
                return Card(
                  child: ListTile(
                    title: Center(child: Text(card.name)),
                    subtitle: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${card.jobTitle} @ '),
                              Text(card.company),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(card.phone),
                              Text(card.email),
                            ],
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditCardScreen(cardId: card.id),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
