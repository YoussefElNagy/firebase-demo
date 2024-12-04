import 'package:flutter/material.dart';

class GiftListPage extends StatefulWidget {
  @override
  _GiftListPageState createState() => _GiftListPageState();
}

class _GiftListPageState extends State<GiftListPage> {
  List<Map<String, dynamic>> gifts = [
    {
      'name': 'Book',
      'event': 'Education Event',
      'status': 'Available',
      'pledged': false,
      'icon': Icons.book,
    },
    {
      'name': 'Car',
      'event': 'Graduation',
      'status': 'Available',
      'pledged': false,
      'icon': Icons.directions_car,
    },
    {
      'name': 'Watch',
      'event': 'Birthday Party',
      'status': 'Pledged',
      'pledged': true,
      'icon': Icons.watch,
    },
    {
      'name': 'iPhone 16',
      'event': 'Senior Year',
      'status': 'Available',
      'pledged': false,
      'icon': Icons.phone_iphone,
    },
    {
      'name': 'Flowers',
      'event': 'Engagement',
      'status': 'Available',
      'pledged': true,
      'icon': Icons.local_florist,
    },
  ];

  void _sortEvents(String criterion) {
    setState(() {
      gifts.sort((a, b) => a[criterion].compareTo(b[criterion]));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Gift List',
          style: TextStyle(
            color: Colors.purple[200],
            fontFamily: 'IndieFlower',
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.purple[200],
        ),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.0,
          ),
          itemCount: gifts.length,
          itemBuilder: (context, index) {
            final gift = gifts[index];
            return Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/gift.png"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                if (gift['pledged'])
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.lightGreenAccent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Pledged',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 40,
                  child: Text(
                    gift['name'],
                    style: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      shadows: [Shadow(offset: Offset(1.5, 1.5), color: Colors.purple)],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                  bottom: 40,
                  child: Column(
                    children: [
                      Text(
                        'Event: ${gift['event']}',
                        style: TextStyle(color: Colors.black38, fontSize: 13, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Status: ${gift['pledged'] ? 'Pledged' : gift['status']}',
                        style: TextStyle(color: Colors.black38, fontSize: 13,fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                if (!gift['pledged'])
                  Positioned(
                    bottom: 6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.purple[200]),
                          onPressed: () => _editGift(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.black38),
                          onPressed: () => _deleteGift(index),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){Navigator.pushNamed(context, '/route5');},
        child: Icon(Icons.add),
        backgroundColor: Colors.purple[200],
      ),
    );
  }

  void _addGift() {
  }

  void _editGift(int index) {
  }

  void _deleteGift(int index) {
    setState(() {
      gifts.removeAt(index);
    });
  }
}
