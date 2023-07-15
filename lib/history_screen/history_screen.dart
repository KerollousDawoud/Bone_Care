import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dopproject/history_screen/cubit/history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryCubit()..getHistory(),
      child: BlocConsumer<HistoryCubit, HistoryState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = HistoryCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.lightBlueAccent,
                title: Text(style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), 'X-Ray History'),
              ),
              body: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    ConditionalBuilder(
                      condition: cubit.history.isNotEmpty,
                      builder: (context) => Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => Stack(
                            children: [
                              Container(
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
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                ),
                                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Image(image: NetworkImage(cubit.history[index].image.toString())),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), cubit.history[index].date.toString()),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), cubit.history[index].note.toString()),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: IconButton(
                                    onPressed: () {
                                      cubit.deleteHistory(id: cubit.history[index].id.toString());
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 40,
                                    )),
                              )
                            ],
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 25,
                          ),
                          itemCount: cubit.history.length,
                        ),
                      ),
                      fallback: (context) => Expanded(
                          child: Center(
                        child: Text('No history yet'),
                      )),
                    )
                  ])));
        },
      ),
    );
  }
}
