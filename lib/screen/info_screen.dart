import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  // final TextEditingController _eidNameController =
  //     TextEditingController(text: "웅이네 오돌뼈 상도점");
  // final TextEditingController _eidController =
  //     TextEditingController(text: "610-38-80314");
  // final TextEditingController _eidAddreesController =
  //     TextEditingController(text: "서울특별시 동작구 상도동 211-176지층 102호");
  final TextEditingController _nameController =
      TextEditingController(text: "웅이네오돌뼈닭발도 상도점");
  List<bool> _isSelected = [true, false, false];
  Map<String, bool> days = {
    "월": false,
    "화": false,
    "수": false,
    "목": false,
    "금": false,
    "토": false,
    "일": false,
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("기본정보 설정"),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Text(
                //   "사업자등록 상호명",
                //   style: TextStyle(
                //     fontSize: 25,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
                // const SizedBox(height: 10),
                // TextField(
                //   enabled: false,
                //   controller: _eidNameController,
                //   decoration: const InputDecoration(
                //       border: OutlineInputBorder(),
                //       contentPadding: EdgeInsets.all(12)),
                //   style: const TextStyle(
                //     fontSize: 22,
                //     color: Colors.black87,
                //   ),
                // ),
                // const SizedBox(height: 15),
                // const Text(
                //   "사업자등록번호",
                //   style: TextStyle(
                //     fontSize: 25,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
                // const SizedBox(height: 10),
                // TextField(
                //   enabled: false,
                //   controller: _eidController,
                //   decoration: const InputDecoration(
                //       border: OutlineInputBorder(),
                //       contentPadding: EdgeInsets.all(12)),
                //   style: const TextStyle(
                //     fontSize: 22,
                //     color: Colors.black87,
                //   ),
                // ),
                // const SizedBox(height: 15),
                // const Text(
                //   "사업자주소",
                //   style: TextStyle(
                //     fontSize: 25,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
                // const SizedBox(height: 10),
                // TextField(
                //   enabled: false,
                //   maxLines: null,
                //   controller: _eidAddreesController,
                //   decoration: const InputDecoration(
                //       border: OutlineInputBorder(),
                //       contentPadding: EdgeInsets.all(12)),
                //   style: const TextStyle(
                //     fontSize: 22,
                //     color: Colors.black87,
                //     height: 1.5,
                //   ),
                // ),
                // const SizedBox(height: 15),
                const Text(
                  "상호명",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  maxLines: null,
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12),
                  ),
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "업종 카테고리",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                const Text("카테고리 선택"),
                const SizedBox(height: 15),
                const Text(
                  "운영시간",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      child: const Text(
                        "운영시간",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        showTimePicker(
                          context: context,
                          initialTime: const TimeOfDay(hour: 0, minute: 0),
                        );
                      },
                    ),
                    OutlinedButton(
                      child: const Text(
                        "준비시간",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        showTimePicker(
                          helpText: "시작시간",
                          context: context,
                          initialTime: const TimeOfDay(hour: 0, minute: 0),
                        );
                      },
                    ),
                    OutlinedButton(
                      child: const Text(
                        "휴무일",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return AlertDialog(
                                  title: const Text(
                                    "휴무일 설정",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ToggleButtons(
                                        isSelected: _isSelected,
                                        constraints: const BoxConstraints(
                                            minHeight: 50, minWidth: 90),
                                        children: const [
                                          Text(
                                            "휴무없음",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            "주",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            "격주",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                        onPressed: (index) {
                                          setState(() {
                                            _isSelected = [false, false, false];
                                            _isSelected[index] = true;
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          for (var day in days.keys)
                                            Container(
                                              height: 35,
                                              width: 35,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.black54),
                                              ),
                                              child: Text(day),
                                            )
                                        ],
                                      )
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text("확인"),
                                      onPressed: () {},
                                    ),
                                    TextButton(
                                      child: const Text("취소"),
                                      onPressed: () {},
                                    )
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
