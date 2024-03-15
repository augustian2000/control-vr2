import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 應用程式的根
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // 應用程式的主題
        //
        // flutter run: 編譯程式
        // r: 直接更新
        // R: 重新跑程式
        //
        // 這也適用於程式碼，而不僅僅是值：大多數程式碼變更只需hot reload即可測試
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: FlutterBluetoothSerial.instance.requestEnable(),
        builder: (context, future) {
          if (future.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Container(
                height: double.infinity,
                child: Center(
                  child: Icon(
                    Icons.bluetooth_disabled,
                    size: 200.0,
                    color: Colors.blue,
                  ),
                ),
              ),
            );
          } else if (future.connectionState == ConnectionState.done) {
            // return MyHomePage(title: 'Flutter Demo Home Page');
            return FirstRoute();
          } else {
            return FirstRoute();
          }
        },
        // child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),//初始頁面
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  

  // 該小部件是您的應用程式的主頁。 它是有狀態的，這意味著它有一個 State 物件（定義如下），其中包含影響其外觀的欄位

  // 這個類別是狀態的配置。 它保存由父級（在本例中為 App 小部件）提供並由 State 的 build 方法使用的值（在本例中為標題）。 Widget 子類別中的欄位總是標記為「final」

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//創建不同頁面
class FirstRoute extends StatefulWidget {
  const FirstRoute({Key? key}) : super(key: key);

  @override
  _FirstRouteState createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  // 初始化气室的频率和时间为默认值
  double chamberFrequency1 = 0.0;
  double chamberFrequency2 = 0.0;
  double chamberFrequency3 = 0.0;
  double chamberFrequency4 = 0.0;
  double chamberFrequency5 = 0.0;
  double chamberTime1 = 0.0;
  double chamberTime2 = 0.0;
  double chamberTime3 = 0.0;
  double chamberTime5 = 0.0;
  double chamberTime4 = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chamber selection'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // 將列中的內容大小設置為最小
          children: <Widget>[

            ElevatedButton(
              onPressed: () async {
                // 使用await等待MyHomePage页面返回的结果
                final List<double>? selectedFrequencies = await Navigator.push<List<double>>(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Chamber Frequency')),
                );

                // 检查返回的列表是否不为空
                if (selectedFrequencies != null && selectedFrequencies.isNotEmpty) {
                  setState(() {
                    // 更新状态以反映所选的频率值
                    chamberFrequency1 = selectedFrequencies[0];
                    chamberFrequency2 = selectedFrequencies[1];
                    chamberFrequency3 = selectedFrequencies[2];
                    chamberFrequency4 = selectedFrequencies[3];
                    chamberFrequency5 = selectedFrequencies[4];
                  });
                }
              },
              child: const Text('Frequency'),
            ),

          const SizedBox(height: 10), // 添加一点空间

            ElevatedButton(
              onPressed: () async {
                final List<double>? selectedTimes = await Navigator.push<List<double>>(
                  context,
                  MaterialPageRoute(builder: (context) => const ChamberTimeControlPage()),
                );
                if (selectedTimes != null && selectedTimes.isNotEmpty) {
                  setState(() {
                    chamberTime1 = selectedTimes[0];
                    chamberTime2 = selectedTimes[1];
                    chamberTime3 = selectedTimes[2];
                    chamberTime4 = selectedTimes[3];
                    chamberTime5 = selectedTimes[4];
                  });
                }
              },
              child: const Text('Time'),
            ),
            const SizedBox(height: 20),
          const SizedBox(height: 20),
          Text('Chamber 1 (Frequency, time): ($chamberFrequency1 hz, $chamberTime1 sec)'),
          Text('Chamber 2 (Frequency, time): ($chamberFrequency2 hz, $chamberTime2 sec)'),
          Text('Chamber 3 (Frequency, time): ($chamberFrequency3 hz, $chamberTime3 sec)'),
          Text('Chamber 4 (Frequency, time): ($chamberFrequency4 hz, $chamberTime4 sec)'),
          Text('Chamber 5 (Frequency, time): ($chamberFrequency5 hz, $chamberTime5 sec)'),

            ElevatedButton(
              onPressed: () {

                // 在這裡添加導航到第三個路由的代碼
              },
              child: const Text('done change'),
            ),
          ],
        ),
      ),
    );
  }
  

  // 添加方法来更新频率和时间
  void updateFrequency(double newFrequency) {
    setState(() {
      chamberFrequency1 = newFrequency;
      chamberFrequency2 = newFrequency;
      chamberFrequency3 = newFrequency;
      chamberFrequency4 = newFrequency;
      chamberFrequency5 = newFrequency;
    });
  }

  void updateTime(double newTime) {
    setState(() {
      chamberTime1 = newTime;
      chamberTime2 = newTime;
      chamberTime3 = newTime;
      chamberTime4 = newTime;
      chamberTime5 = newTime;
    });
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: Text('Content of Second Route'),
        ),
      );
  }
}

class ThirdRoute extends StatelessWidget {
  const ThirdRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ThirdRoute'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChamberTimeControlPage()),
            );
            // Navigate back to first route when tapped.
          },
          child: const Text('Control Chamber Time'),
        ),
      ),
    );
  }
}

class ChamberTimeControlPage extends StatefulWidget {
  const ChamberTimeControlPage({Key? key}) : super(key: key);

  @override
  _ChamberTimeControlPageState createState() => _ChamberTimeControlPageState();
}

class _ChamberTimeControlPageState extends State<ChamberTimeControlPage> {
  double chamber1_time = 0.0;
  double chamber2_time = 0.0;
  double chamber3_time = 0.0;
  double chamber4_time = 0.0;
  double chamber5_time = 0.0;
  
  get selectedFrequency => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chamber Time Control'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Adjust the time for each chamber:'),
            sliderSection('Chamber 1', chamber1_time, (newValue) {
              setState(() => chamber1_time = newValue);
            }),
            sliderSection('Chamber 2', chamber2_time, (newValue) {
              setState(() => chamber2_time = newValue);
            }),
            sliderSection('Chamber 3', chamber3_time, (newValue) {
              setState(() => chamber3_time = newValue);
            }),
            sliderSection('Chamber 4', chamber4_time, (newValue) {
              setState(() => chamber4_time = newValue);
            }),
            sliderSection('Chamber 5', chamber5_time, (newValue) {
              setState(() => chamber5_time = newValue);
            }),

            ElevatedButton(
            onPressed: () {
              // 封装所有频率的值到一个列表中
              List<double> selectedFrequencies = [
                chamber1_time,
                chamber2_time,
                chamber3_time,
                chamber4_time,
                chamber5_time,
              ];
              // 使用 Navigator.pop 返回这个列表
              Navigator.pop(context, selectedFrequencies);
            },
             child: const Text('Finish'),
            ),
          ],
        ),
      ),
    );
  }

  Widget sliderSection(String title, double value, ValueChanged<double> onChanged) {
    return Column(
      children: [
        Text(
          '$title: ${value.toStringAsFixed(1)} sec',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SfSlider(
          min: 0.0,
          max: 60.0, // 假设最大时间为60分钟
          value: value,
          interval: 10,
          showTicks: true,
          showLabels: true,
          enableTooltip: true,
          minorTicksPerInterval: 1,
          stepSize: 1.0, // 可以调整步长为1分钟
          onChanged: (newValue) => onChanged(newValue),
        ),
      ],
    );
  }
}

class SharedContent extends StatelessWidget {
  const SharedContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Shared content between pages'),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {

  double chamber1_freq = 0.0; //將_value作為變量
  double chamber2_freq = 0.0; //將_value作為變量
  double chamber3_freq = 0.0; //將_value作為變量
  double chamber4_freq = 0.0; //將_value作為變量
  double chamber5_freq = 0.0;
  
  get selectedFrequencyValue => null; //將_value作為變量

  @override
  Widget build(BuildContext context) {

    // 每次呼叫 setState 時都會重新執行此方法，例如上面的 _incrementCounter 方法。
    // Flutter 框架已經最佳化，可以快速重新執行建置方法，這樣您就可以重建任何需要更新的內容，而不必單獨更改小部件的實例。

    return Scaffold(
      appBar: AppBar(                                                   // 試試看：嘗試將此處的顏色變更為特定顏色（也許變更為 Colors.amber？）並觸發熱重載以查看 AppBar 變更顏色，而其他顏色保持不變。  
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,  // 在這裡，我們從 App.build 方法建立的 MyHomePage 物件中取得值，並使用它來設定應用程式欄標題。
       
        title: Text(widget.title),
      ),
      body: Center(                                                     // Center 是佈局小工具。 它需要一個子節點並將其放置在父節點的中間
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,                  // Column 也是佈局小工具。 它需要一個子列表並垂直排列它們。 預設情況下，它會調整自身大小以水平適應其子級，並嘗試與父級一樣高
          children: <Widget>[                                           // Column 有各種屬性來控制它本身的大小以及它的子項的位置。 這裡使用 mainAxisAlignment 使子元素垂直居中； 
            
            const Text('Adjust the frequency for each chamber:'),
            sliderSection('Chamber 1', chamber1_freq, (newValue) {
              setState(() => chamber1_freq = newValue);
            }),
            sliderSection('Chamber 2', chamber2_freq, (newValue) {
              setState(() => chamber2_freq = newValue);
            }),
            sliderSection('Chamber 3', chamber3_freq, (newValue) {
              setState(() => chamber3_freq = newValue);
            }),
            sliderSection('Chamber 4', chamber4_freq, (newValue) {
              setState(() => chamber4_freq = newValue);
            }),
            sliderSection('Chamber 5', chamber5_freq, (newValue) {
              setState(() => chamber5_freq = newValue);
            }),
            
            ElevatedButton(
            onPressed: () {
              // 封装所有频率的值到一个列表中
              List<double> selectedFrequencies = [
                chamber1_freq,
                chamber2_freq,
                chamber3_freq,
                chamber4_freq,
                chamber5_freq,
              ];
              // 使用 Navigator.pop 返回这个列表
              Navigator.pop(context, selectedFrequencies);
            },
             child: const Text('Finish'),
            )// 可在此添加更多小部件
          ],
        ),
      ),// 這個尾隨逗號使建置方法的自動格式化變得更好。
    );
  }

  Widget sliderSection(String title, double value, ValueChanged<double> onChanged) {
    return Column(
      children: [
        Text(
          '$title: ${value.toStringAsFixed(1)}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SfSlider(
          min: 0.0,
          max: 10.0,
          value: value,
          interval: 2,
          showTicks: true,
          showLabels: true,
          enableTooltip: true,
          minorTicksPerInterval: 1,
          stepSize: 0.5,
          onChanged: (newValue) => onChanged(newValue),
        ),
      ],
    );
  }
}
