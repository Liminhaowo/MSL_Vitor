import 'package:flutter/material.dart';
import 'package:instagram_flutter/widgets/stories.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: const Text(
              'InstaAtual',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_box_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.send_outlined),
              ),
            ],
          ),
          const SliverToBoxAdapter(child: Stories()),
          const SliverToBoxAdapter(child: Divider(height: 1)),

          const SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.flutter_dash, color: Colors.white),
                  ),
                  title: Text(
                    'flutter.dev',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('São Paulo, Brasil'),
                ),
                SizedBox(
                  height: 330,
                  width: double.infinity,
                  child: ColoredBox(
                    color: Colors.blue,
                    child: Icon(
                      Icons.flutter_dash,
                      color: Colors.white,
                      size: 130,
                    ),
                  ),
                ),
                const Row(
                  children: [
                    Icon(Icons.favorite_border),
                    SizedBox(width: 8,),
                    Icon(Icons.mode_comment_outlined),
                    SizedBox(width: 8,),
                    Icon(Icons.favorite_border),
                    SizedBox(width: 8,),
                    
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
