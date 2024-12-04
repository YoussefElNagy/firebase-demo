import 'package:flutter/material.dart';

class EventListPage extends StatefulWidget {
  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  final List<Map<String, dynamic>> events = [
    {'name': 'Birthday Party', 'category': 'Celebration', 'status': 'Past'},
    {'name': 'Graduation Ceremony', 'category': 'Education', 'status': 'Upcoming'},
    {'name': 'Senior Year', 'category': 'Education', 'status': 'Current'},
    {'name': 'Engagement', 'category': 'Celebration', 'status': 'Past'},
    {'name': 'A Match', 'category': 'Sport', 'status': 'Upcoming'},
  ];

  void _sortEvents(String criterion) {
    setState(() {
      events.sort((a, b) => a[criterion].compareTo(b[criterion]));
    });
  }

  void _deleteEvent(int index) {
    setState(() {
      events.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: Text(
          'Event List',
          style: TextStyle(
            color: Colors.purple[200],
            fontFamily: 'IndieFlower',
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
        color: Colors.purple[200] ),
        actions: [
          PopupMenuButton<String>(
            onSelected: _sortEvents,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: 'name', child: Text('Sort by Name')),
                PopupMenuItem(value: 'category', child: Text('Sort by Category')),
                PopupMenuItem(value: 'status', child: Text('Sort by Status')),
              ];
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          event['name'],
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[200],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.purple[200]),
                              onPressed: () => _editEvent(index),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.black38),
                              onPressed: () => _deleteEvent(index),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      'Category: ${event['category']}',
                      style: TextStyle(fontSize: 17, color: Colors.grey[700]),
                    ),
                    Text(
                      'Status: ${event['status']}',
                      style: TextStyle(fontSize: 17, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Adding Event");
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple[200],
      ),
    );
  }

  void _editEvent(int index) {
  }
}
