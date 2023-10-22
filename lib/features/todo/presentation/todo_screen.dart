import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_todo/app_colors.dart';
import 'package:my_todo/enums.dart';
import 'package:my_todo/features/todo/presentation/provider.dart';
import '../data/todo_model.dart';

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  @override
  void initState() {
    ref.read(todoProvider.notifier).fetchTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(onPressed: (){
        //   ref.read(todoProvider.notifier).fetchTodos();
        // },),
        body: Container(
          color: AppColor.backgroundColor,
          width: double.infinity,
          child: Column(
            children: [
              _buildAppBar(context),
              const SizedBox(
                height: 20,
              ),
              _buildStatusCard(context, ref),
              const SizedBox(
                height: 20,
              ),
              _buildToDoList(context, ref),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildToDoList(BuildContext context, WidgetRef ref) {
  final provider = ref.watch(todoProvider);
  final List<ToDo> data = provider.todoList;
  // provider.setEventStateInitial();
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: data.isEmpty
          ? Center(
              child: (provider.eventState == EventState.Initial ||
                      provider.eventState == EventState.Loading)
                  ? CircularProgressIndicator()
                  : Text('Oops, Data not found.'),
            )
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, ind) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 10,
                    child: Container(
                        height: 65,
                        decoration: BoxDecoration(
                          color: data[ind].completed
                              ? AppColor.doneCardColor
                              : AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: data[ind].completed
                                        ? AppColor.whiteColor
                                        : AppColor.doneCardColor),
                                child: Center(
                                  child: Text(
                                    data[ind]
                                        .title
                                        .substring(0, 1)
                                        .toUpperCase(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.primaryColor),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  data[ind].title,
                                  textAlign: TextAlign.start,
                                )),
                            Expanded(
                                flex: 2,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: data[ind].completed
                                        ? const Icon(
                                            Icons.check_circle,
                                            color: AppColor.primaryColor,
                                          )
                                        : const SizedBox()))
                          ],
                        )),
                  ),
                );
              }),
    ),
  );
}

Widget _buildStatusCard(BuildContext context, WidgetRef ref) {
  final double height = MediaQuery.of(context).size.height;
  final double width = MediaQuery.of(context).size.width;
  final provider = ref.watch(todoProvider);
  final data = provider.todoList;
  return Container(
    height: height * 0.28,
    width: width * 0.95,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0.0, 1.0), //(x,y)
          blurRadius: 6.0,
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        StatusRowWidget(
          title: 'ToDo',
          statusColor: Colors.green,
          taskCount: data.length,
        ),
        StatusRowWidget(
          title: 'In Progress',
          statusColor: Colors.purple,
          taskCount: data.length - provider.completeCount,
        ),
        StatusRowWidget(
          title: 'Done',
          statusColor: AppColor.primaryColor,
          taskCount: provider.completeCount,
        ),
      ],
    ),
  );
}

class StatusRowWidget extends StatelessWidget {
  final String title;
  final int taskCount;
  final Color statusColor;
  const StatusRowWidget({
    super.key,
    required this.title,
    required this.taskCount,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 1,
          child: CircleAvatar(
            backgroundColor: statusColor,
            child: Text(
              title.substring(0, 1),
              style: const TextStyle(color: AppColor.whiteColor),
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
              textAlign: TextAlign.start,
            )),
        Expanded(
            flex: 2,
            child: Text("$taskCount tasks", textAlign: TextAlign.center)),
      ],
    );
  }
}

Widget _buildAppBar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 50.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 24.0),
            child: Text(
              'My Todo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notification_add,
              size: 24,
            ))
      ],
    ),
  );
}
