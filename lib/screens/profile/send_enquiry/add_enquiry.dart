import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/components/default_button.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/models/enquiry/category_enquiry.dart';
import 'package:flutterbase/models/enquiry/file_setting_enquiry.dart';
import 'package:flutterbase/models/organizations/organization.dart';
import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';

import 'package:line_icons/line_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/utils/helpers.dart';

class AddEnquiryScreen extends StatefulWidget {
  @override
  State<AddEnquiryScreen> createState() => _AddEnquiryScreenState();
}

class _AddEnquiryScreenState extends State<AddEnquiryScreen> {
  late FocusNode myFocusNode;

  TextEditingController tecTitle = TextEditingController();
  TextEditingController tecRefNo = TextEditingController();
  TextEditingController tecDesc = TextEditingController();

  // ignore: unused_field
  List<Organization> _organizationModel = [];
  List<FileSettingEnquiry> _fileSettingModel = [];
  bool varAllowMultiple = false;
  bool gotFile = false;
  // ignore: unused_field
  List _enquiryModel = [
    {
      "id": "1",
      "dateTime": "2022-10-26 22:05:33",
      "noTicket": "P000000002",
      "titleEnquiry": "Resit tidak terima dalam email",
      "catEnquiry": "Tiada",
      "statusEnquiry": "Baharu"
    },
    {
      "id": "2",
      "dateTime": "2022-10-27 22:05:33",
      "noTicket": "P000000003",
      "titleEnquiry": "Resit tidak keluar dalam email",
      "catEnquiry": "Tiada",
      "statusEnquiry": "Baharu"
    },
    {
      "id": "3",
      "dateTime": "2022-10-28 22:05:33",
      "noTicket": "P000000004",
      "titleEnquiry": "Resit tidak ketepi dalam email",
      "catEnquiry": "Tiada",
      "statusEnquiry": "Baharu"
    },
    {
      "id": "4",
      "dateTime": "2022-10-29 22:05:33",
      "noTicket": "P000000005",
      "titleEnquiry": "Resit tidak ketengah dalam email",
      "catEnquiry": "Tiada",
      "statusEnquiry": "Baharu"
    }
  ];
  List<CategoryEnquiry> _enquiryCategory = [];
  String enquiryTitle = '';
  String enquiryDescription = '';
  String enquiryNumber = '';
  bool enquiryNumberIsValid = false;
  int? _enquiryCategoryID;
  int? _enquirySettingId;
  int? agencyId;
  Organization? _selectedOrg;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  List<File> files = [];
  late String fileType = "";
  List<String> extensionFile = [];
  String userType = "";

  String referenceBillOrReceiptExits = 'empty';

  List<dynamic> _fileFormatList = [];
  List<dynamic> _imageFormatList = [];

  bool _isBillRequired = false;

  String _enquiryRefNo = '0';

  int? fileSize;

  @override
  void initState() {
    super.initState();
    _getData();

    myFocusNode = FocusNode();
  }

  void getEnquiryRefNo() async {
    await api.getEnquiryRefNo(_enquiryRefNo);
    setState(() {
      if (store.getItem('isRefNoLS').toString() == '1') {
        print('Wajib');
        _isBillRequired = true;
      } else {
        print('Tidak');
        _isBillRequired = false;
      }
    });
  }

  void _getData() async {
    if (store.getItem('rolesLS') != 'civilServant') {
      setState(() {
        userType = "user";
      });
    } else {
      setState(() {
        userType = "notuser";
      });
    }
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    _enquiryCategory = await api.getEnquiryCategory(userType);
    _fileSettingModel = await api.getFileSettingEnquiry();
    _organizationModel = await api.getOrganization();

    _organizationModel.insert(
        0,
        Organization(
          [],
          id: 0,
          orgEmail: '',
          orgName: 'Diri Sendiri',
          orgTypeId: 0,
          userId: 0,
          orgRegistrationNo: '',
          dateExtablished: '',
          stateId: 0,
          address1: '',
          address2: '',
          address3: '',
          postcode: '',
          districtId: 0,
          cityId: 0,
          phoneNo: '',
          status: 0,
        ));

    _selectedOrg = _organizationModel[0];

    _enquiryCategory.sort((a, b) {
      return a.name!.toLowerCase().compareTo(b.name!.toLowerCase());
    });

    _organizationModel.sort((a, b) {
      return a.orgName!.toLowerCase().compareTo(b.orgName!.toLowerCase());
    });
    // if (fileSetting[0].allow_multiple_upload == 1) {
    //   setState(() {
    //     varAllowMultiple = true;
    //   });
    // }

    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          _fileSettingModel.map((item) {
            _fileFormatList.add(item.file_format);
            _imageFormatList.add(item.image_format);
          }).toList();

          var newList = [
            _fileFormatList,
            _imageFormatList,
          ].expand((x) => x).toList();

          var newListFormatter = newList
              .toString()
              .replaceAll(new RegExp(r"\p{P}", unicode: true), "");

          String s = newListFormatter.toString();
          List<String> list = s.split(" ");

          _enquiryCategory = _enquiryCategory;
          extensionFile = list;

          print(list);

          fileSize = _fileSettingModel[0].file_size;

          print(fileSize);

          //  _organizationModel.map((item) {
          //   _fileFormatList.add(item.file_format);
          //   _imageFormatList.add(item.image_format);
          // }).toList();

          // List<Organization> _defaultOrgId = [];
          // _defaultOrgId.add(Organization('Select'));
          // _defaultOrgId.addAll(_organizationModel); //Your list from JSON

          Navigator.pop(context);
        }));
  }

  // Future refresh() async {
  //   _organizationModel = await api.getOrganization();
  //   Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  // }

  // Widget buildTile(Organization organization) => ListTile(
  //       title: Text(organization.orgName!),
  //     );

  //! Nombor rujukan / nombor resit
  // onChangedEmail(String emailPattern) {
  //   setState(() {
  //       _isEmailValid = false;
  //       if (emailRE.hasMatch(emailPattern)) _isEmailValid = true;
  //     },
  //   );
  // }
  // Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
  //       referenceBillOrReceiptExits =
  //           store.getItem('hasRBORValueLS').toString();
  //       // print(referenceBillOrReceiptExits);

  //       Navigator.pop(context);
  //     }));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            LineIcons.angleLeft,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(true),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 55),
          child: Center(
            child: Text(
              'New Enquiry'.tr,
              style: styles.heading1sub,
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                DropdownButtonFormField<Organization>(
                  icon: Visibility(
                      visible: true, child: Icon(LineIcons.chevronCircleDown)),
                  focusNode: myFocusNode,
                  isExpanded: true,
                  decoration: styles.inputDecoration.copyWith(
                    label: getRequiredLabel('On Behalf'.tr),
                  ),
                  hint: Text('Please Select'.tr),
                  selectedItemBuilder: (BuildContext context) {
                    return _organizationModel.map((dynamic value) {
                      return Text(value.orgName!,
                          overflow: TextOverflow.visible);
                    }).toList();
                  },
                  items: _organizationModel.map((item) {
                    return new DropdownMenuItem<Organization>(
                      child: new Text(item.orgName!),
                      value: item,
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'This field cannot be left blank.'.tr;
                    }
                    return null;
                  },
                  onChanged: (Organization? _org) {
                    setState(() {
                      _selectedOrg = _org!;
                      //     print(newVal);
                      //     // _enquiryRefNo = newVal.toString();
                      //     // getEnquiryRefNo();
                      //     // _enquiryCategoryID = int.parse(newVal.toString());
                      //     // _enquirySettingId = int.parse(newVal.toString());
                    });
                  },
                  value: _selectedOrg,
                ),
                SizedBox(height: 20),
                DropdownButtonFormField(
                  icon: Visibility(
                      visible: true, child: Icon(LineIcons.chevronCircleDown)),
                  focusNode: myFocusNode,
                  isExpanded: true,
                  decoration: styles.inputDecoration.copyWith(
                    label: getRequiredLabel('Category'.tr),
                  ),
                  hint: Text('Please Select'.tr),
                  selectedItemBuilder: (BuildContext context) {
                    return _enquiryCategory.map((dynamic value) {
                      return Text(value.name!, overflow: TextOverflow.visible);
                    }).toList();
                  },
                  items: _enquiryCategory.map((item) {
                    return new DropdownMenuItem(
                      child: new Text(item.name!),
                      value: item.id,
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'This field cannot be left blank.'.tr;
                    }
                    return null;
                  },
                  onChanged: (newVal) {
                    setState(() {
                      // print(newVal);

                      _enquiryRefNo = newVal.toString();

                      getEnquiryRefNo();

                      _enquiryCategoryID = int.parse(newVal.toString());
                      _enquirySettingId = int.parse(newVal.toString());
                    });
                  },
                  value: _enquiryCategoryID,
                ),
                SizedBox(height: 20),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: tecTitle,
                  decoration: styles.inputDecoration.copyWith(
                    label: getRequiredLabel('Title'.tr),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be left blank.'.tr;
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      enquiryTitle = tecTitle.text;
                    });
                  },
                ),
                Visibility(
                  visible: _isBillRequired,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: TextFormField(
                      controller: tecRefNo,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textAlign: TextAlign.justify,
                      decoration: styles.inputDecoration.copyWith(
                          errorMaxLines: 5,
                          label: getRequiredLabel('Reference Number'.tr),
                          hintText:
                              'Bill reference number / receipt number'.tr),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be left blank.'.tr;
                        } else if (!enquiryNumberIsValid) {
                          return "The number (@enquiryNumber) entered is not in the database."
                              .trParams({'enquiryNumber': enquiryNumber});
                        }
                        return null;
                      },
                      onChanged: (val) async {
                        int? _agencyId = await api.referenceBillOrReceipt(val);
                        setState(() {
                          agencyId = _agencyId;
                          enquiryNumber = tecRefNo.text;
                          enquiryNumberIsValid = _agencyId != null;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: tecDesc,
                  textAlign: TextAlign.justify,
                  autocorrect: false,
                  maxLines: 5,
                  decoration: styles.inputDecoration.copyWith(
                    contentPadding: EdgeInsets.all(16),
                    alignLabelWithHint: true,
                    errorMaxLines: 5,
                    label: getRequiredLabel('Description'.tr),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be left blank.'.tr;
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      enquiryDescription = tecDesc.text;
                    });
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Supporting Document".tr, style: styles.heading12bold),
                    IconButton(
                        onPressed: selectFile,
                        icon: Icon(Icons.attach_file,
                            color: constants.primaryColor)),
                  ],
                ),
                files.length > 0
                    ? ListView.builder(
                        itemCount: files.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Card(
                            color: Color(0xFFF5F6F9),
                            child: ListTile(
                              title: Text(
                                files[index]
                                    .path
                                    .split('/')
                                    .last
                                    .toString()
                                    .toTitleCase(),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.redAccent),
                                onPressed: () {
                                  setState(() {
                                    files.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          );
                        })
                    : Container()
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: DefaultButton(
                    text: 'Reset'.tr,
                    onPressed: () {
                      setState(() {
                        _enquiryCategoryID = null;
                        tecTitle.clear();
                        tecRefNo.clear();
                        tecDesc.clear();
                      });
                    }),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 7,
                child: PrimaryButton(
                  isLoading: _isLoading,
                  text: 'Send'.tr,
                  onPressed: _isLoading
                      ? null
                      : () async {
                          setState(() {
                            _isLoading = true;
                          });
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });

                            try {
                              var response = await api.submitEnquiry(
                                _enquiryCategoryID!,
                                _enquirySettingId!,
                                state.user.id.toString(),
                                enquiryNumber,
                                enquiryTitle,
                                enquiryDescription,
                                files,
                                _selectedOrg!,
                                agencyId,
                              );
                              if (response.isSuccessful) {
                                setState(() {
                                  _isLoading = false;
                                });
                                snack(context,
                                    "Pertanyaan anda telah berjaya dihantar.",
                                    level: SnackLevel.Success);
                                Navigator.of(context).pop(true);
                              } else {
                                setState(() {
                                  _isLoading = false;
                                });
                                Get.snackbar(
                                  snackPosition: SnackPosition.TOP,
                                  "".tr,
                                  response.message,
                                  messageText: Text(
                                    response.message,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16,
                                    ),
                                  ),
                                  padding:
                                      EdgeInsets.only(bottom: 30, left: 16),
                                  backgroundColor: Colors.red,
                                );
                              }
                            } catch (e) {
                              print(e);
                              snack(
                                  context,
                                  "There is a problem connecting to the server. Please try again."
                                      .tr);
                            }
                          }
                          setState(() {
                            _isLoading = false;
                          });
                        },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: varAllowMultiple,
      type: FileType.custom,
      allowedExtensions: extensionFile,
    );

    var extensionFileFormatter = extensionFile
        .toString()
        .replaceAll("{", "")
        .replaceAll("[", "")
        .replaceAll("]", "")
        .replaceAll("}", "");

    if (result != null) {
      num totalByte = 0;
      for (var i = 0; i < result.files.length; i++) {
        totalByte += result.files[i].size;
      }
      if (totalByte > fileSize! * 1000000) {
        Get.snackbar(
          snackPosition: SnackPosition.TOP,
          "".tr,
          'Please select a file format '.tr +
              extensionFileFormatter.toString() +
              ' and the size does not exceed '.tr +
              fileSize.toString() +
              ' MB.',
          messageText: Text(
            'Please select a file format '.tr +
                extensionFileFormatter.toString() +
                ' and the size does not exceed '.tr +
                fileSize.toString() +
                ' MB.',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
          padding: EdgeInsets.only(bottom: 30, left: 16),
          backgroundColor: Colors.red,
        );
      } else {
        setState(() {
          files = result.paths.map((path) => File(path!)).toList();
          gotFile = true;
        });

        for (var i = 0; i < files.length; i++) {}
      }
    } else {
      // User canceled the picker
    }
  }
}
