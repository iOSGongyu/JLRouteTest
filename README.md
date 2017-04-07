# JLRouteTest
*The use of JLRoutes*
![image](https://github.com/iOSGongyu/JLRouteTest/blob/master/JLRoutesTest_0002.gif)

核心类及方法说明：
SystemMediator处理所有的业务注册及调度：  

**1.业务注册**。  
&emsp;&emsp;使用JLRoutes的业务注册方法进行注册，将接受参数分为4块，module表示业务，target代表业务中的某个类，action代表类中的方法，parameter代表方法接受的参数，真正有用的是target和parameter，其他参数用于标识。     
***注意***：所有的被调用类在初始化后，统一调用一个方法去设置参数，即setParameter：方法，参数为json字符串，json字段每个类确定，调用时传入即可。

    [[JLRoutes globalRoutes] addRoute:@"/:module/:target/:action/:parameter" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        //业务调度
    }]

**2.业务调度。**  
&emsp;&emsp;利用OC语言的runtime特性，动态创建。

    Class targetClass = NSClassFromString(targetClassString);
    id object = [[targetClass alloc] init];
    if ([object respondsToSelector:@selector(setParameterJsonString:)]) {
        [object performSelector:@selector(setParameterJsonString:) withObject:parameters[@"parameter"]];
    }

**3.如何调用？**  
&emsp;&emsp;在demo中我写了两个业务，在业务A的主页中，通过url schemes去调相关的页面。

    NSURL *viewUrl；
    NSDictionary *dict = @{@"text" : @"业务A 原生 页面"};
    NSString *jsonStr = [self dataTOjsonString:dict];
    NSString *urlStr = [NSString stringWithFormat:@"JLRoutesTest://MouduleA/ModuleANativePageViewController/setParameter/%@",jsonStr];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    viewUrl = [NSURL URLWithString:urlStr];
    [[SystemMediator sharedInstance] openModuleWithURL:viewUrl];

&emsp;&emsp;在这段代码中，我按照在1中约定的规则，传入响应的数据，JLRoutesTest是代表app本身，一般来说由外部app调用时必须使用；MouduleA代表业务A；ModuleANativePageViewController代表业务A下的一个页面；setParameter是要调用的设置方法；jsonStr是setParameter需要的参数。

**4.RN页面如何打开原生页面? **   
&emsp;&emsp;RNOpenNativeMediator类负责，RN文件中调用方法后，会执行本类中的方法，然后根据参数进行处理，实际调度方法与以上相同，本类主要负责与RN通信。
