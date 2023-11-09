import 'package:flutter/material.dart';

class InfoScreen2 extends StatefulWidget {
  const InfoScreen2({super.key});

  @override
  State<InfoScreen2> createState() => _InfoScreen2State();
}

String searchSector = "";
List<String> items = ["item1", "item2", "item3", "item4"];

class _InfoScreen2State extends State<InfoScreen2> {
  final _nameKey = GlobalKey<FormState>();
  final _oldNameController = TextEditingController(text: "기존의 매장명");
  final _newNameController = TextEditingController();
  final _sectorsKey = GlobalKey<FormState>();
  final _oldSectorsController = TextEditingController(text: "기존의 업종");
  final _newSectorsController = TextEditingController();
  String? _selectSector;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: DefaultTabController(
        initialIndex: 0,
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("매장 정보 변경"),
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: Container(
                color: Colors.white,
                height: 60,
                child: TabBar(
                  isScrollable: true,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  onTap: (value) => FocusScope.of(context).unfocus(),
                  labelColor: Colors.white70,
                  labelStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelColor: Colors.black54,
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 18,
                  ),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 3),
                  indicator: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  indicatorPadding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 3,
                  ),
                  tabs: [
                    infoTab("매장명"),
                    infoTab("업종"),
                    infoTab("사진"),
                    infoTab("영업시간"),
                    infoTab("연락처"),
                    infoTab("기타"),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              nameTabBarView(),
              sectorsTabBarView(),
              const Center(child: Text("three")),
              const Center(child: Text("four")),
              const Center(child: Text("five")),
              const Center(child: Text("six")),
            ],
          ),
        ),
      ),
    );
  }

  Tab infoTab(String text) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
        ),
      ),
    );
  }

  SingleChildScrollView nameTabBarView() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "기존의 매장명",
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 10),
            TextField(
              enabled: false,
              controller: _oldNameController,
              maxLines: null,
              style: const TextStyle(fontSize: 22),
              decoration: const InputDecoration(
                  counterStyle: TextStyle(fontSize: 18),
                  filled: true,
                  fillColor: Color.fromARGB(255, 238, 238, 238),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    width: 2.5,
                    color: Colors.grey,
                  ))),
            ),
            const Divider(
              color: Colors.black38,
              thickness: 1,
              height: 50,
            ),
            const Text(
              "변경할 매장명",
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 10),
            Form(
              key: _nameKey,
              child: TextFormField(
                minLines: 1,
                maxLines: null,
                maxLength: 30,
                controller: _newNameController,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(
                    counterStyle: TextStyle(fontSize: 18),
                    filled: true,
                    fillColor: Color.fromARGB(255, 238, 238, 238),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      width: 2.5,
                      color: Colors.grey,
                    ))),
                validator: (value) {
                  // 입력된 값 공백제거
                  var trimValue = value!.replaceAll(RegExp("\\s"), "");
                  if (trimValue.length < 2) {
                    return "2자 이상, 30자 이하로 입력해주세요.";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "매장명은 간판과 같은 이름으로 설정해야 이용자들이 쉽게 찾을 수 있습니다.",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
              ),
            )
          ],
        ),
      ),
    );
  }

  SingleChildScrollView sectorsTabBarView() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "현재 매장 업종",
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 10),
            TextField(
              enabled: false,
              controller: _oldSectorsController,
              maxLines: null,
              style: const TextStyle(fontSize: 22),
              decoration: const InputDecoration(
                  counterStyle: TextStyle(fontSize: 18),
                  filled: true,
                  fillColor: Color.fromARGB(255, 238, 238, 238),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    width: 2.5,
                    color: Colors.grey,
                  ))),
            ),
            const Divider(
              color: Colors.black38,
              thickness: 1,
              height: 50,
            ),
            const Text(
              "업종 변경",
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 10),
            Form(
              key: _sectorsKey,
              child: TextFormField(
                controller: _newSectorsController,
                style: const TextStyle(fontSize: 22),
                onChanged: (value) {
                  setState(() {
                    searchSector = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "업종을 검색해주세요.",
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: searchSector.isEmpty
                      ? const Icon(Icons.search, size: 35)
                      : IconButton(
                          icon: const Icon(Icons.cancel_rounded),
                          onPressed: () {
                            _newSectorsController.clear();
                            setState(() {
                              searchSector = "";
                            });
                          },
                        ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            // https://luvris2.tistory.com/681
            ListView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (searchSector.isNotEmpty &&
                    items[index]
                        .toLowerCase()
                        .contains(searchSector.toLowerCase())) {
                  return RadioListTile(
                    title: Text(
                      items[index],
                      style: const TextStyle(fontSize: 20),
                    ),
                    value: items[index],
                    groupValue: _selectSector,
                    onChanged: (value) {
                      setState(() {
                        _selectSector = value;
                        _newSectorsController.text = value!;
                      });
                    },
                    contentPadding: const EdgeInsets.all(0),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
