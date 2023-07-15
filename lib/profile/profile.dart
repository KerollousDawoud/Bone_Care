import 'package:cached_network_image/cached_network_image.dart';
import 'package:dopproject/login_screen/Login.dart';
import 'package:dopproject/profile/profile_cubit/profile_cubit.dart';
import 'package:dopproject/shared/cacheHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..Profile(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = ProfileCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.lightBlueAccent,
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: InkWell(
                              onTap: () {
                                cubit.imageProfile(context);
                              },
                              child: Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(80)),
                                clipBehavior: Clip.antiAlias,
                                child: CachedNetworkImage(
                                    imageUrl: cubit.img.toString() != 'null'
                                        ? cubit.img.toString()
                                        : 'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png',
                                    placeholder: (context, url) => Image.asset('assets/2815428.png')),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Icon(Icons.person, color: Colors.lightBlueAccent, size: 50),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            '${cubit.name} ',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Icon(Icons.email, color: Colors.lightBlueAccent, size: 50),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              '${cubit.email}',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Icon(Icons.calendar_month, color: Colors.lightBlueAccent, size: 50),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  '${cubit.age} Y',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Icon(Icons.scale, color: Colors.lightBlueAccent, size: 50),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  '${cubit.weight} KG',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Icon(Icons.height, color: Colors.lightBlueAccent, size: 50),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  '${cubit.height} CM',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            await CacheHelper.removeData(key: 'login');
                            await CacheHelper.removeData(key: 'uId');
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => Login()));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlueAccent,
                              elevation: 10.0,
                              textStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                          child: const Text('Sign Out'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
