import 'package:english_words/english_words.dart'; // 引入生成隨機英文單字組合的套件
import 'package:flutter/foundation.dart'; // 引入 Flutter 的 Foundation 庫
import 'package:flutter/material.dart'; // 引入 Material Design 的元件
import 'package:provider/provider.dart'; // 引入 Provider 用於狀態管理

void main() {
  runApp(const MyApp()); // 啟動 Flutter 應用，根組件為 MyApp
}

// 主應用程式類別，繼承 StatelessWidget，無狀態管理
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // 建構函數，使用 super.key 初始化

  @override
  Widget build(BuildContext context) {
    // 忽略 "always_specify_types" 的 lint 警告，這裡可以不指定類型
    // ignore: always_specify_types
    return ChangeNotifierProvider(
      create: (BuildContext context) => MyAppState(), // 建立並提供 MyAppState
      child: MaterialApp(
        title: 'Flutter Hello World', // 應用程式的標題
        theme: ThemeData(
          useMaterial3: true, // 使用 Material Design 3 的風格
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepOrange, // 使用深橙色作為主色
          ),
        ),
        home: const MyHomePage(), // 設定首頁為 MyHomePage
      ),
    );
  }
}

// 應用狀態類別，繼承 ChangeNotifier 以支持狀態通知
class MyAppState extends ChangeNotifier {
  WordPair current = WordPair.random(); // 生成一個隨機的英文單字組合

  // 方法：生成下一組隨機單字並通知監聽者狀態已改變
  void getNext() {
    current = WordPair.random(); // 更新 current 為新隨機單字組合
    notifyListeners(); // 通知所有監聽該狀態的元件重新渲染
  }
}

// 首頁介面，繼承 StatelessWidget
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key}); // 建構函數，使用 super.key 初始化

  @override
  Widget build(BuildContext context) {
    // 透過 context 取得並監聽 MyAppState 狀態
    final MyAppState appState = context.watch<MyAppState>();
    final WordPair pair = appState.current; // 取得當前的隨機單字組合

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 內容置中對齊
          children: <Widget>[
            BigCard(pair: pair), // 大字卡顯示當前隨機生成的單字
            const SizedBox(height: 10), // 增加按鈕與單字卡之間的距離
            ElevatedButton(
              onPressed: () {
                appState.getNext(); // 點擊按鈕後生成下一個單字組合
                if (kDebugMode) {
                  print('Next button pressed!'); // 在 Debug 模式下印出提示
                }
              },
              child: const Text('Next'), // 按鈕顯示 'Next' 文本
            ),
          ],
        ),
      ),
    );
  }
}

// 自定義組件 BigCard，用於顯示單字組合
class BigCard extends StatelessWidget {
  const BigCard({
    required this.pair, // 需要傳入一個 WordPair 單字組合
    super.key,
  });

  final WordPair pair; // 儲存單字組合

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context); // 取得目前的主題
    final TextStyle style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary, // 設定字體顏色為主色系上的對比色
    );

    return Card(
      color: theme.colorScheme.primary, // 設定卡片背景顏色為主色
      child: Padding(
        padding: const EdgeInsets.all(20.0), // 設定內邊距
        child: Text(
          pair.asLowerCase, // 顯示小寫的單字組合
          style: style, // 使用設定的文字樣式
          semanticsLabel: "${pair.first} ${pair.second}", // 用於無障礙訪問的標籤
        ),
      ),
    );
  }
}
