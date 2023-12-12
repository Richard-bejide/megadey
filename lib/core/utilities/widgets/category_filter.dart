import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:megadey_mobile/core/utilities/widgets/range_tile.dart';
import 'package:megadey_mobile/core/utilities/widgets/rounded_button.dart';
import '../../constants/colors.dart';
import 'bottomsheet_drag_button.dart';

class ApplyFilters extends StatefulWidget {
  final String category;

  ApplyFilters({Key? key, required this.category}) : super(key: key);

  @override
  State<ApplyFilters> createState() => _ApplyFiltersState();
}

class _ApplyFiltersState extends State<ApplyFilters> {

  //Price filter
  RangeValues? defaultPriceRange;
  RangeValues? selectedPriceRange;
  TextEditingController startPriceController = TextEditingController();
  TextEditingController endPriceController = TextEditingController();

  List<String?>? priceRange2 = [
    'Under 50K',
    '50-150k',
    '150-250k',
    'More than 250k',
  ];

  String selectedPriceRange2 = '';


  //discount filter
  List<String?>? discountPercentages = [
    '50% or more',
    '40% or more',
    '30% or more',
    '20% or more',
    '10% or more',
  ];
  String selectedDiscountPercentage = '';


  //specific filter different for each category
  List<String?>? genders = [
    'Female',
    'Male',
    'Unisex',
  ];
  String selectedGender = '';

  //condition filter
  List<String?>? productConditions = [
    'Brand New',
    'Refurbished',
    'Used',
  ];
  String selectedProductCondition = '';

  //exchange possible filter
  List<String?>? exchangePossible = [
    'Yes',
    'No',
  ];

  String selectedExchangePossible = '';

TextEditingController locationController = TextEditingController();
  String selectedLocation = 'All Nigeria';

  void getFilters() async {
    defaultPriceRange = RangeValues(12300, 500400);
    selectedPriceRange = defaultPriceRange;
    startPriceController.text = '12300';
    endPriceController.text = '500400';
    setState(() {});
  }

  @override
  void initState() {
    getFilters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              BottomsheetDragButton(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/filter.svg',
                          color: Colors.black, height: 20),
                      const SizedBox(width: 5),
                      Text(
                        'Filters',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          // fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Clear All',
                        style: TextStyle(
                          color: Palette.primaryColor,
                          fontSize: 14,
                          // fontFamily: 'Circular Std',
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.24,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    card(
                      'Price',
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RangeTile(
                              max: defaultPriceRange!.end,
                              min: defaultPriceRange!.start,
                              values: selectedPriceRange!,
                              doubleSlider: true,
                              onChanged: (value) {
                                selectedPriceRange = value;
                                startPriceController.text =
                                    selectedPriceRange!.start.round().toString();
                                endPriceController.text = selectedPriceRange!.end.round().toString();
                                setState(() {});
                              },
                            ),
                            const SizedBox(height: 3),
                            Row(children: [
                              Expanded(
                                  child: textField(
                                      labelText: 'From',
                                      keyBoardType: TextInputType.number,
                                      onChanged: (val) {
                                        // selectedPriceRange =  RangeValues(double.parse(val!), selectedPriceRange!.end);
                                        // setState(() {});
                                      },
                                      controller: startPriceController)),
                              const SizedBox(width: 15),
                              Expanded(
                                  child: textField(
                                      labelText: 'To',
                                      keyBoardType: TextInputType.number,
                                      onChanged: (val) {
                                        // selectedPriceRange =  RangeValues(selectedPriceRange!.start,double.parse(val!));
                                        // setState(() {});
                                      },
                                      controller: endPriceController))
                            ]),
                            const SizedBox(height: 10),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: priceRange2?.length,
                                itemBuilder: (BuildContext context, int index){
                                  return GestureDetector(
                                      child: radioWidget(priceRange2![index]!, selectedPriceRange2),
                                      onTap: () {
                                        selectedPriceRange2 = priceRange2![index]!;
                                        setState(() {});
                                      });
                                })

                          ]),
                    ),
                    const SizedBox(height: 20),
                        card(
                        'Discount Percentage',
                        ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: discountPercentages?.length,
                                itemBuilder: (BuildContext context, int index){
                                  return GestureDetector(
                                      child: radioWidget(discountPercentages![index]!, selectedDiscountPercentage),
                                      onTap: () {
                                        selectedDiscountPercentage = discountPercentages![index]!;
                                        setState(() {});
                                      });
                                })
                         ),
                    const SizedBox(height: 20),
                    card(
                        'Gender',
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: genders?.length,
                            itemBuilder: (BuildContext context, int index){
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: GestureDetector(
                                    child: radioWidget(genders![index]!, selectedGender),
                                    onTap: () {
                                      selectedGender = genders![index]!;
                                      setState(() {});
                                    }),
                              );
                            })
                    ),
                    const SizedBox(height: 20),
                    card(
                        'Location',
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                           textField(
                             enabled: false,
                               onChanged: (val){},
                               controller: locationController),
                            const SizedBox(height: 10),
                            SizedBox(
                              width:250,
                              child: Text(
                                selectedLocation,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  color: Color(0xFFBB00DA),
                                  fontSize: 14,
                                  // fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: (){
                                //get user's location
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_on_outlined,size: 20,color: Palette.primaryColor),
                                  const SizedBox(width: 2),
                                  Text(
                                    'My Location',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      // fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                    ),
                    const SizedBox(height: 20),
                    card(
                        'Condition',
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: productConditions?.length,
                            itemBuilder: (BuildContext context, int index){
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: GestureDetector(
                                    child: radioWidget(productConditions![index]!, selectedProductCondition),
                                    onTap: () {
                                      selectedProductCondition = productConditions![index]!;
                                      setState(() {});
                                    }),
                              );
                            })
                    ),  const SizedBox(height: 20),
                    card(
                        'Exchange Possible',
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: exchangePossible?.length,
                            itemBuilder: (BuildContext context, int index){
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                 child: GestureDetector(
                                    child: radioWidget(exchangePossible![index]!, selectedExchangePossible),
                                    onTap: () {
                                      selectedExchangePossible = exchangePossible![index]!;
                                      setState(() {});
                                    }),
                              );
                            })
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: CustomButton(
                          title: 'Apply Filters',
                          onPressed:(){
                            //apply filter then pop
                            Navigator.pop(context);
                          },
                          buttonColor: Palette.primaryColor,
                          textColor: Colors.white),
                    ),
                    const SizedBox(height: 40),
                    ]),
                ),
              ),
            ]),
        ),
      ),
    );
  }

  Widget card(String title, Widget child) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration:
          BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              // fontFamily: 'DM Sans',
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Divider(color: Colors.grey.withOpacity(0.3), height: 1),
          const SizedBox(height: 3),
          child
        ],
      ),
    );
  }

  Widget textField(
      {
        bool enabled = true,
        String? labelText,
       TextInputType? keyBoardType,
      required Function(String? val) onChanged,
      required TextEditingController controller}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText != null
            ? Text(labelText, style: TextStyle(color: Palette.customGrey, fontSize: 11, fontWeight: FontWeight.w500))
            : const SizedBox(),
        const SizedBox(height: 1),
        SizedBox(
          height: 35,
          child: TextFormField(
            enabled: enabled,
            onChanged: onChanged,
            maxLines: 1,
            controller: controller,
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
            keyboardType: keyBoardType == TextInputType.number
                ? const TextInputType.numberWithOptions(signed: false, decimal: false)
                : keyBoardType,
            inputFormatters: keyBoardType == TextInputType.number
                ? [FilteringTextInputFormatter.digitsOnly]
                : [],
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Palette.primaryColor.withOpacity(0.2), width: 1.0),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Palette.primaryColor.withOpacity(0.2), width: 1.0)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Palette.primaryColor.withOpacity(0.2), width: 1.0)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Palette.primaryColor.withOpacity(0.2), width: 1.0)),
            ),
          ),
        ),
      ],
    );
  }

  Widget radioWidget(String title, String groupValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Radio(
            activeColor: Palette.primaryColor,
            value: title,
            groupValue: groupValue,
            onChanged: (value) {
              print(value); //selected value
            }),
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            // fontFamily: 'DM Sans',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}