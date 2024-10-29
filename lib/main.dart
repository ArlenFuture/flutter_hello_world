import 'package:english_words/english_words.dart'; // 引入英文單字生成的套件
import 'package:flutter/material.dart'; // 引入 Flutter 的 Material Design 元件
import 'package:provider/provider.dart'; // 引入 Provider 套件，用於狀態管理

void main() {
  runApp(const MyApp()); // 啟動應用程式，並傳入 MyApp 組件
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // 建構函數，使用 super.key 初始化

  @override
  Widget build(BuildContext context) {
    // 忽略 "always_specify_types" 的 lint 警告，這裡可以不指定類型
    // ignore: always_specify_types
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          MyAppState(), // 建立 MyAppState 的實例，並提供給樹中的子組件
      child: MaterialApp(
        title: 'Flutter Hello World', // 應用程式的標題
        theme: ThemeData(
          useMaterial3: true, // 使用 Material Design 3 的主題
          colorScheme:
              ColorScheme.fromSeed(seedColor: Colors.deepOrange), // 設定色彩方案
        ),
        home: const MyHomePage(), // 設定應用程式的首頁為 MyHomePage
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  WordPair current = WordPair.random(); // 生成一個隨機的英文單字

  // 定義一個方法 getNext，當呼叫此方法時會生成新的隨機單字
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key}); // 建構函數，使用 super.key 初始化

  @override
  Widget build(BuildContext context) {
    // 使用 context 監聽 MyAppState 的變化
    final MyAppState appState = context.watch<MyAppState>();

    return Scaffold(
      body: Column(
        children: <Widget>[
          const Text('A random AWESOME idea:'), // 顯示標題文字
          Text(appState.current.asLowerCase), // 顯示當前隨機生成的單字（小寫）

          // ElevatedButton 是一個帶有陰影的按鈕元件，當按下時會觸發 onPressed 的回呼函式
          ElevatedButton(
            onPressed: () {
              appState.getNext();
              print('button pressed!');
            },
            // child 是按鈕內的內容，這裡是一個 Text 元件，顯示 'Next'
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
