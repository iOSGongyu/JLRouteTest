//
//  ModuleAMainViewController.m
//  JLRouteTest
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "ModuleAMainViewController.h"
#import "SystemMediator.h"
#import "ModuleAModel.h"

@interface ModuleAMainViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSArray *dataAry;

@end

@implementation ModuleAMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // 导航栏
    self.navigationController.navigationBarHidden = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 64)];
    label.backgroundColor = [UIColor colorWithRed:230/255.0f green:33/255.0f blue:41/255.0f alpha:1.0f];
    label.text = @"业务一主页";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    [self.view addSubview:self.table];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64-44) style:UITableViewStylePlain];
        _table.dataSource = self;
        _table.delegate = self;
    }
    return _table;
}

- (NSArray *)dataAry {
    if (!_dataAry) {
        _dataAry = @[@"点我进入业务A 原生 页面",@"点我进入业务A RN 页面",@"点我进入业务A H5 页面"];
    }
    return _dataAry;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataAry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    [cell.textLabel setText:self.dataAry[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSURL *viewUrl;
    if (indexPath.row == 0) {
        NSDictionary *dict = @{@"text":@"业务A 原生 页面"};
        NSString *jsonStr = [self dataTOjsonString:dict];
        NSString *urlStr = [NSString stringWithFormat:@"JLRoutesTest://MouduleA/ModuleANativePageViewController/setParameter/%@",jsonStr];
        urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        viewUrl = [NSURL URLWithString:urlStr];
        
    } else if (indexPath.row == 1) {
        viewUrl = [NSURL URLWithString:@"JLRoutesTest://MouduleA/ModuleARNPageViewController/setParameter/666"];
        
    } else if (indexPath.row == 2) {
        viewUrl = [NSURL URLWithString:@"JLRoutesTest://MouduleA/ModuleAH5PageViewController/setParameter/666"];
        
    } else {
        viewUrl = [[NSURL alloc] init];
        
    }
    
    [[SystemMediator sharedInstance] openModuleWithURL:viewUrl];
}

- (NSString*)dataTOjsonString:(id)object {
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

@end
