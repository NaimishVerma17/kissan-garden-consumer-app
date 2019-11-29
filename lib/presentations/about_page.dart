import 'package:flutter/material.dart';
import 'package:kissan_garden/utils/styles.dart';

class AboutPage extends StatelessWidget {
  String _aboutKissanGarden =
      'Kissan Garden is India’s online Fruits, Vegetables and Dry fruits store. We have a wide range of seasonal and non seasonal Fruits, Vegetables and Dry Fruits in our catalogue. A one stop solution for your daily nutritious requirements. Choose from a wide range of options in every category, exclusively handpicked to help you find the best quality available at the lowest prices. Select a time slot for delivery and your order will be delivered right at your doorstep in accordance to the time scheduled by you, anywhere in Dehradun and surroundings. You can pay by cash on delivery after checking for the quality and the quantity of your order. We guarantee on time delivery and the best quality!';

  String _useCase =
      'Whenever I visit India, I could see my mother struggling to buy quality Fruits and Vegetables from street shops or online platforms. Poor quality of Fruits and Vegetables which were delivered by Online Platforms(renowned stores) further added to her misery. So I decided to come up with an online platform catering to the common local customers, who have faced similar quality and delayed delivery issues from other different online stores available in the market. As you begin your journey with us and initiate orders with Kissan Garden portal, we ensure hygienic and high quality of all the listed products on our portal and would make sure for a hassle free delivery with in the timeline selected by you. Discover new products and shop for all your needs from the comfort of your home or office. No more getting stuck in traffic jams, paying for parking, standing in long queues and carrying heavy bags – get everything you need, when you need, right at your doorstep!!! Happy Shopping!!';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: Styles.pageTitleText(),
        ),
        elevation: 3.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Styles.primaryColor),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'What is Kissan Garden?',
                style: Styles.headingText(),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                _aboutKissanGarden,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Why should I use Kissan Garden?',
                style: Styles.headingText(),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                _useCase,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
