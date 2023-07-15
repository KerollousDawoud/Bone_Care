import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dopproject/pharmacy_screen/cubit/pharmacy_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';

class Pharmacy extends StatelessWidget {
  const Pharmacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PharmacyCubit(),
      child: BlocConsumer<PharmacyCubit, PharmacyState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = PharmacyCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.lightBlueAccent,
              title: Text(
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  'Pharmacy'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(children: [
                    Expanded(
                      child: Container(
                        height: 30,
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(color: Colors.lightBlueAccent, borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: DropDown(
                            onChanged: (value) {
                              cubit.getDoctor(city: value.toString());
                            },
                            isExpanded: true,
                            showUnderline: false,
                            items: ["Cairo", "Giza", "Luxor", "Aswan", "Alexandria", "Qina", "Monofia"],
                            hint: Center(
                              child: Text(style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white), 'Government'),
                            ),
                            icon: Icon(
                              Icons.expand_more,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                  ConditionalBuilder(
                    condition: cubit.doctor.isNotEmpty,
                    builder: (context) => Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 10,
                                offset: Offset(5, 5), // Shadow position
                              ),
                            ],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          width: double.infinity,
                          child: Column(
                            children: [
                              CachedNetworkImage(
                                  imageUrl: cubit.doctor[index].image.toString(), placeholder: (context, url) => Image.asset('assets/2815428.png')),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Text(
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.lightBlueAccent,
                                    ),
                                    'Pharmasy Name : ',
                                  ),
                                  Expanded(
                                    child: Text(
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      cubit.doctor[index].name.toString(),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Text(
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.lightBlueAccent,
                                    ),
                                    'Phone : ',
                                  ),
                                  Expanded(
                                    child: Text(
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      cubit.doctor[index].phone.toString(),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Text(
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.lightBlueAccent,
                                    ),
                                    'Address : ',
                                  ),
                                  Expanded(
                                    child: Text(
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      cubit.doctor[index].address.toString(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 20,
                        ),
                        itemCount: cubit.doctor.length,
                      ),
                    ),
                    fallback: (context) => Expanded(
                      child: Center(
                        child: Text('Select a city'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
