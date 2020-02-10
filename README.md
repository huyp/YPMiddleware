# YPMiddleware

用于模块化项目中,不同模块之间的互相调用.不需要import目标模块,利用runtime查找目标Class进行实例化.完全解耦模块之间的依赖关系.

## 实例化方法
1. +(nullable id)getInstanceWithClassName:(nonnull NSString *)className;

```
用于默认的new初始化方法实例化对象.

id v2 = [YPMiddleware getInstanceWithClassName:@"OtherViewController"];
```

2. +(nullable id)getInstanceWithClassName:(nonnull NSString *)className customInstanceFunction:(nonnull NSString *)function;
```
自定义无参数的初始化方法实例化对象

id v2 = [YPMiddleware getInstanceWithClassName:@"OtherViewController" customInstanceFunction:@"shareInstance"];
```

3. +(nullable id)getInstanceWithClassName:(nonnull NSString *)className customInstanceFunction:(nonnull NSString *)function params:(nonnull id)params, ... NS_REQUIRES_NIL_TERMINATION;
```
自定义带参数的初始化方法实例化对象

id v2 = [YPMiddleware getInstanceWithClassName:@"OtherViewController" customInstanceFunction:@"initWithMsg:" params:@"jacky", nil];
```
