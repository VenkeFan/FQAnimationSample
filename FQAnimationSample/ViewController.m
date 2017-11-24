//
//  ViewController.m
//  FQAnimationSample
//
//  Created by fanqi on 17/6/26.
//  Copyright © 2017年 fanqi. All rights reserved.
//

#import "ViewController.h"

#import "FQ3DScrollViewController.h"
#import "FQWaveViewController.h"
#import "FQRollerCoasterViewController.h"


#define DataDictionaryNameKey       @"name"
#define DataDictionaryClassKey      @"class"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"FQAnimationSample";
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * const reuseId = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseId];
    }
    
    cell.textLabel.text = [self.dataArray[indexPath.row] objectForKey:DataDictionaryNameKey];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.dataArray[indexPath.row];
    Class cls = [dic objectForKey:DataDictionaryClassKey];
    
    UIViewController *ctr = [cls new];
    [self.navigationController pushViewController:ctr animated:YES];
}

#pragma mark - Getter & Setter

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
        [_dataArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                               [FQ3DScrollViewController class], DataDictionaryClassKey,
                               @"3DScrollView", DataDictionaryNameKey, nil]];
        [_dataArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                               [FQWaveViewController class], DataDictionaryClassKey,
                               @"波浪动画", DataDictionaryNameKey, nil]];
        [_dataArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                               [FQRollerCoasterViewController class], DataDictionaryClassKey,
                               @"过山车动画", DataDictionaryNameKey, nil]];
    }
    return _dataArray;
}


@end
