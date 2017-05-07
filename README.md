# JSExportTest
使用JSExport进行JS与OC的数据交互。JSExport是一个协议，通过实现它可以完成把一个native对象暴漏给js,JSContext是JavaScript的运行上下文，他主要作用是执行js代码和注册native方法接口。

## JavaScriptObject
这个类继承于NSObject,主要是用来实现JSExport协议的。
例如，JavaScriptObject.h中声明协议方法

```
@import JavaScriptCore;
@protocol JavaScriptObjectExport <JSExport>
- (NSString *)get_app_version;
- (NSString *)db_insert:(NSString *)name :(NSString *)value; // 插入数据
@end
```
相应的在JavaScriptObject.m中需要实现协议方法，

```
- (NSString *)get_app_version{
    NSLog(@"获取软件版本号");
    NSString *bundleStr = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *returnBundleStr = [NSString stringWithFormat:@"iOS_%@",bundleStr];
    return returnBundleStr;
}

- (NSString *)db_insert:(NSString *)name :(NSString *)value{
    NSLog(@"\n插入数据名称---%@\n插入数据    ---%@",name,value);
    NSDictionary *dict = @{name:value};
    return [self toJsonWithDict:dict];
}
```

## js里面通过对象调用方法
在webView的代理方法中，

```
- (void)webViewDidStartLoad:(UIWebView *)webView {
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    _javaScriptObj = [[JavaScriptObject alloc] init];
    context[@"iOS"] = _javaScriptObj;
}
```

## 对比用于测试的test.html文件
如下，

```
<script type="text/javascript">   

function db_insert() {       
var content=iOS.db_insert("I am KEY","I am Value");

var text=document.getElementById("aaaa");

text.innerHTML =content;
}

function get_app_version() {
	var content=iOS.get_app_version();
    
    var text=document.getElementById("aaaa");
    
    text.innerHTML = content;
}

</script>
```
对应的对象为<font color = #FA8072>iOS.db_insert("I am KEY","I am Value")，iOS.get_app_version()</font>