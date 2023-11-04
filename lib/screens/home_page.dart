import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userlist/custom_widgets/custom_text.dart';
import 'package:userlist/models/user_model.dart';
import 'package:userlist/provider/user_provider.dart';
import 'package:userlist/screens/detail_page.dart';
import 'package:userlist/utilities/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.userList}) : super(key: key);

  final List<Users>? userList;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Users> displayedUsers = [];
  Set<int> starredUsers = <int>{};

  @override
  void initState() {
    super.initState();
    if (widget.userList != null) {
      displayedUsers = widget.userList!;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<UserProvider>(context, listen: false).getAllUsers();
      });
    }
  }

  void searchUsers(String text) {
    setState(() {
      _searchController.text = text;
      displayedUsers = widget.userList!
          .where((user) =>
      user.name?.toLowerCase().contains(text.toLowerCase()) == true ||
          user.email?.toLowerCase().contains(text.toLowerCase()) == true)
          .toList();
    });
  }

  void toggleStarredUser(int userId) {
    setState(() {
      if (starredUsers.contains(userId)) {
        starredUsers.remove(userId);
      } else {
        starredUsers.add(userId);
      }
    });
  }

  bool isUserStarred(int userId) {
    return starredUsers.contains(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                margin: const EdgeInsets.symmetric(vertical: 27, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.search),
                    Expanded(
                      child: TextFormField(
                        controller: _searchController,
                        showCursor: false,
                        onFieldSubmitted: searchUsers,
                        decoration: const InputDecoration(
                          hintText: 'Search Users',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Consumer<UserProvider>(
                  builder: (context, value, child) {
                    if (value.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final userDatas = displayedUsers.isNotEmpty
                        ? displayedUsers
                        : value.userDatas;

                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: userDatas.length,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final users = userDatas[index];
                        final userId = users.id ?? -1;

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Detailpage(
                                  name: users.name,
                                  email: users.email,
                                  street: users.address?.street,
                                  city: users.address?.city,
                                  zipcode: users.address?.zipcode,
                                  phone: users.phone,
                                  website: users.website,
                                  cname: users.company?.name,
                                  catchPhrase: users.company?.catchPhrase,
                                  bs: users.company?.bs,
                                  lat: users.address?.geo?.lat,
                                  lng: users.address?.geo?.lng,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: 'Name : ',
                                      value: value.userDatas[index].name,
                                    ),
                                    CustomText(
                                      text: 'Street : ',
                                      value: users.address?.street,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: Icon(
                                    isUserStarred(userId) ? Icons.star : Icons.star_border,
                                    color: isUserStarred(userId) ? Constants.primaryColor : Constants.blackColor,
                                  ),
                                  onPressed: () {
                                    toggleStarredUser(userId);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
