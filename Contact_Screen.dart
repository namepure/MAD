import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Contact_Page extends StatefulWidget {
  const Contact_Page({super.key});

  @override
  State<Contact_Page> createState() => _Contact_PageState();
}

class _Contact_PageState extends State<Contact_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              width: 150,
              height: 150,
              image: NetworkImage(
                  'https://archives.mfu.ac.th/wp-content/uploads/2019/06/Mae-Fah-Luang-University-2.png'),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'มหาวิทยาลัยแม่ฟ้าหลวง ',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.black, fontSize: 24),
            ),
            Text(
              'Mae Fah Luang University ',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.black, fontSize: 18),
            ),
            Text(
              '333 หมู่ 1 ต.ท่าสุด อ.เมือง จ. เชียงราย 57100',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.black, fontSize: 16),
            ),
            Text(
              'โทรศัพท์ 0-5391-6000, 0-5391-7034 ',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.black, fontSize: 18),
            ),
            Text(
              'โทรสาร 0-5391-6034, 0-5391-7049 ',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.black, fontSize: 18),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'หน่วยประสานงานมหาวิทยาลัยแม่ฟ้าหลวง กรุงเทพฯ ​​​​ ​​​',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.black, fontSize: 14),
            ),
            Text(
              'โทรศัพท์ 0-2679-0038-9 ',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.black, fontSize: 18),
            ),
            Text(
              'โทรสาร 0-2679-0038 ',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.black, fontSize: 18),
            ),
          ],
        ),
      )),
    );
  }
}
