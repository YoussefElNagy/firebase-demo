import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  bool _isEditing = false;

  final List<Map<String, dynamic>> gifts = [
    {'name': 'Book', 'event': 'Education Event', 'status': 'Available', 'pledged': false, 'icon': Icons.book},
    {'name': 'Car', 'event': 'Graduation', 'status': 'Available', 'pledged': false, 'icon': Icons.directions_car},
    {'name': 'Watch', 'event': 'Birthday Party', 'status': 'Pledged', 'pledged': true, 'icon': Icons.watch},
    {'name': 'iPhone 16', 'event': 'Senior Year', 'status': 'Available', 'pledged': false, 'icon': Icons.phone_iphone},
    {'name': 'Flowers', 'event': 'Engagement', 'status': 'Pledged', 'pledged': true, 'icon': Icons.local_florist},
  ];

  @override
  void initState() {
    super.initState();
    _nameController.text = "Joliana Emad";
    _phoneController.text = "01210370304";
    _emailController.text = "juliana.ata1593@gmail.com";
    _ageController.text = "22";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 600,
                backgroundColor: Colors.black,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/myProfile.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [
                            Colors.black,
                            Colors.black.withOpacity(.3),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            _isEditing
                                ? TextField(
                              controller: _nameController,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter Name',
                                hintStyle: TextStyle(color: Colors.white60),
                              ),
                            )
                                : Text(
                              _nameController.text,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height:5),
                        Row(
                          children: [
                            Text(
                              "Born",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "August 19th, 2002, Cairo, Egypt",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "Nationality",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Egyptian",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.cake, color: Colors.white60),
                            SizedBox(width: 8),
                            _isEditing
                                ? Expanded(
                              child: TextField(
                                controller: _ageController,
                                style: TextStyle(color: Colors.white),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: "Enter Age",
                                  hintStyle: TextStyle(color: Colors.white60),
                                  border: InputBorder.none,
                                ),
                              ),
                            )
                                : Text(
                              _ageController.text,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.phone, color: Colors.white60),
                            SizedBox(width: 8),
                            _isEditing
                                ? Expanded(
                              child: TextField(
                                controller: _phoneController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Enter Phone Number",
                                  hintStyle: TextStyle(color: Colors.white60),
                                  border: InputBorder.none,
                                ),
                              ),
                            )
                                : Text(
                              _phoneController.text,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.email_rounded, color: Colors.white60),
                            SizedBox(width: 8),
                            _isEditing
                                ? Expanded(
                              child: TextField(
                                controller: _emailController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Enter Email",
                                  hintStyle: TextStyle(color: Colors.white60),
                                  border: InputBorder.none,
                                ),
                              ),
                            )
                                : Text(
                              _emailController.text,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),

                        SizedBox(height: 40),
                        Text(
                          "Your Events and Gifts",
                          style: TextStyle(
                              color: Colors.purple[200],
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: gifts.length,
                          itemBuilder: (context, index) {
                            final gift = gifts[index];
                            return Card(
                              color: Colors.black87,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                leading: Icon(gift['icon'], color: Colors.purple[200]),
                                title: Text(
                                  gift['event'],
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  '${gift['name']} - ${gift['pledged'] ? 'Pledged' : 'Available'}',
                                  style: TextStyle(color: Colors.grey[400]),
                                ),
                                trailing: Icon(
                                  gift['pledged'] ? Icons.check_circle : Icons.radio_button_unchecked,
                                  color: gift['pledged'] ? Colors.purple : Colors.grey,
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isEditing = !_isEditing;
                              });
                            },
                            child: Text(_isEditing ? 'Save' : 'Edit'),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
