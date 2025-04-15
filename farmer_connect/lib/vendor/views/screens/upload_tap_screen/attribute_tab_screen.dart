import 'package:farmer_connect/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttributeTabScreen extends StatefulWidget {
  @override
  State<AttributeTabScreen> createState() => _AttributeTabScreenState();
}

class _AttributeTabScreenState extends State<AttributeTabScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final TextEditingController _sizeController = TextEditingController();
  bool _entered = false;
  List<String> _sizeList = [];
  bool _isSave = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Column(
      children: [
        TextFormField(
          validator: ((value) {
            if (value!.isEmpty) {
              return 'Please enter your Brand name';
            } else {
              return null;
            }
          }),
          onChanged: (value) {
            _productProvider.getFormData(brandName: value);
          },
          decoration: InputDecoration(
            labelText: 'Brand',
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: Container(
                width: 100,
                child: TextFormField(
                  controller: _sizeController,
                  onChanged: (value) {
                    setState(() {
                      _entered = true;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Size'),
                ),
              ),
            ),
            _entered == true
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purpleAccent),
                    onPressed: () {
                      setState(() {
                        _sizeList.add(_sizeController.text);
                        _sizeController.clear();
                      });
                      print(_sizeList);
                    },
                    child: Text(
                      'ADD',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  )
                : Text(''),
          ],
        ),
        if (_sizeList.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _sizeList.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _sizeList.removeAt(index);
                          _productProvider.getFormData(sizeList: _sizeList);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.lime,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _sizeList[index],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        if (_sizeList.isNotEmpty)
          ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent),
            onPressed: () {
              _productProvider.getFormData(sizeList: _sizeList);

              setState(() {
                _isSave = true;
              });
            },
            child: Text(
              _isSave ? 'Saved' : 'Save',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3),
            ),
          ),
      ],
    );
  }
}
