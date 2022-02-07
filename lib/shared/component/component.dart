
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'cubit/cubit.dart';

Widget buildTaskItem(Map model,context)=>Dismissible(
  key:Key(model['id'].toString()),
  child:   Padding(

    padding: const EdgeInsets.all(20),

    child: Row(children:

    [
      CircleAvatar(
        radius: 40.0,
        child: Text(
          '${model['time']}',
        ),
      ),
      SizedBox(width: 20.0,),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children:[
            Text(
              '${model['title']}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              '${model['date']}',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),),

      SizedBox(

        width: 20.0,

      ),

      IconButton(

        onPressed:()

        {

          AppCubit.get(context).updateData(

              status: 'done',

              id: model['id']);

        },

        icon: Icon(

          Icons.check_box,

          color: Colors.green,

        ),

      ),

      IconButton(

        onPressed:()

        {

          AppCubit.get(context).updateData(

              status: 'archive',

              id: model['id']);

        },

        icon: Icon(

          Icons.archive,

          color: Colors.black45,

        ),

      ),



    ]

      ,),

  ),
  onDismissed: (direction)
  {
    AppCubit.get(context).deleteData(id: model['id']);
  },
);

Widget tasksBuilder({
  required List<Map>tasks,
})=>ConditionalBuilder(
  condition: tasks.length>0,
  builder: (context)=>ListView.separated(
      itemBuilder: (context,index)=>buildTaskItem(tasks[index],context),




      separatorBuilder: (context,index)=>
          Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 20.0,
          end: 20,
        ),
        child: Container(
          width: double.infinity ,
          height: 1,
          color: Colors.grey[300],
        ),
      ),
      itemCount: tasks.length),
  fallback: (context)=>Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 100.0,
          color: Colors.grey,
        ),
        Text(
          'No Tasks Yet ,Please Add Some Tasks',
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey
          ),
        ),
      ],
    ),
  ),
);

Widget myDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
    end: 20,
  ),
  child: Container(
    width: double.infinity ,
    height: 1,
    color: Colors.grey[300],
  ),
);

Widget buildArticleItems(article,context)
{
  var image =article['urlToImage']?? 'https://www.pulsecarshalton.co.uk/wp-content/uploads/2016/08/jk-placeholder-image.jpg';
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: Row(
      children:
      [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage(image),
              fit:BoxFit.cover,

            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child:
                Text(
                  '${article['title']}',
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )),
                Text('${article['publishedAt']}',
                  style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600),

                ),


              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget articleBuilder(list, [BuildContext? context])=>ConditionalBuilder(
  condition:  list.length>0,
  builder: (context)=>ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context,index) =>buildArticleItems(list[index],context),
      separatorBuilder: (context,index)=>myDivider(),
      itemCount: list.length),
  fallback: (context)=>Center(child: CircularProgressIndicator()),
);

void navigateTo(context,widget)=>Navigator.push(context,
MaterialPageRoute(builder: (context)=>widget),
);