import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_advanced_demo_package/flutter_advanced_demo_package.dart';

void main() {
  test('file handle', () async {
    final fileHandler = FileHandler();
    expect((await fileHandler.writeFileWithString("data.txt", "file data")).path, (await fileHandler.getLocalFile("file data")).path);
    expect(await fileHandler.readFileAsString("data.txt"), "file data");
    //实际上这里的test都是通不过的，因为path_provider是个plugin，在package内，无法模拟一个Android或iOS环境，故无法通过测试。
    //这里测试的功能，可以在引用package的app中进行。
  });
}
