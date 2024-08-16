import 'package:ecommerce_int2/app/user_and_seller/controller/userController.dart';
import 'package:ecommerce_int2/app/user_and_seller/model/servicemen.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/service_men/add_service_men.dart';
import 'package:ecommerce_int2/helper/base.dart';
import 'package:ecommerce_int2/main.dart';
import 'package:ecommerce_int2/shared/controllers/commonController.dart';
import 'package:flutter/material.dart';

// For listing service men with particular service type selected by the seller
class ServiceMenList extends StatefulWidget {
  static String routeName = '/service_men_list';

  const ServiceMenList({super.key});

  @override
  State<ServiceMenList> createState() => _ServiceMenListState();
}

class _ServiceMenListState extends State<ServiceMenList> {
  @override
  Widget build(BuildContext context) {
    final serviceId = context.extra['service_id'];
    final serviceName = context.extra['service_name'];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => finish(context)),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeInImage(
              fit: BoxFit.contain,
              height: 46,
              alignment: Alignment.center,
              placeholder: AssetImage('assets/icons/service.png'),
              image:
                  AssetImage('assets/icons/${serviceName.toLowerCase()}.png'),
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/icons/service.png', height: 56);
              },
            ),
            Text(
              serviceName,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                height: 2,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: IconButton(
          onPressed: () {
            launch(context, AddServiceMen.routeName,serviceId);
          },
          icon: Icon(
            Icons.add,
            size: 32,
          )),
      body: FutureBuilder(
          future: UserController.getSellerServicemenList(serviceId),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Container(
                    margin: EdgeInsets.only(top: 32),
                    child:snapshot.data.length>0? ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      separatorBuilder: (_, i) {
                        return SizedBox(width: 16);
                      },
                      itemBuilder: (_, i) {
                        ServiceMen services = snapshot.data[i];
                        return Column(children: <Widget>[
                          ListTile(
                            title: Text(
                              'Details',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.orangeAccent,
                              ),
                            ),
                            leading: Icon(
                              Icons.person,
                              color: Colors.orangeAccent,
                            ),
                          ),
                          ListTile(
                            title: Text("User: ${services.name}"),
                          ),
                          ListTile(
                            title: Text("phone: ${services.phone}"),
                          ),
                          ListTile(
                            title: Text("emil: ${services.email}"),
                          ),
                          Divider(),
                        ]);
                      },
                    ): Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                      'No users Found',
                      style: CommonController.primaryTitleBlack
                          .copyWith(color: Colors.grey, fontSize: 16),
                                      ),
                    ),
                  );
            } else {
              return Text(
                    'No users Found',
                    style: CommonController.primaryTitleBlack
                        .copyWith(color: Colors.grey, fontSize: 16),
                  );
            }
          }),
    );
  }
}
