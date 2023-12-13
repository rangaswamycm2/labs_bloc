import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labtask_bloc/utils/app_widgets.dart';
import 'package:labtask_bloc/utils/global_styles.dart';

import '../bloc/posts_bloc.dart';
class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final PostsBloc postsBloc = PostsBloc();

  @override
  void initState() {
    postsBloc.add(PostsInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{
        postsBloc.add(PostsInitialFetchEvent());
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Posts Data'),
             centerTitle: true,
            elevation: 0,
            actions: [
              IconButton(onPressed: (){
                postsBloc.add(PostsInitialFetchEvent());
              },
                  icon: const Icon(Icons.refresh_outlined))

            ],
          ),

          body: BlocBuilder<PostsBloc, PostsState>(
            bloc: postsBloc,
            builder: (context, state) {
              switch (state.runtimeType) {
                case PostsFetchingLoadingState:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case PostFetchingSuccessfulState:
                  final successState = state as PostFetchingSuccessfulState;
                  return ListView.builder(
                    itemCount: successState.posts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 5,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Title : ",style: GlobalStyles.greyColorTS),
                                Text(successState.posts[index].title,style: GlobalStyles.bodyTS),
                               AppWidgets.size10h,
                                Text("Body : ",style: GlobalStyles.greyColorTS),
                                Text(successState.posts[index].body,style: GlobalStyles.bodyTS)
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                default:
                  return const SizedBox();
              }
            },
          )),
    );
  }
}
