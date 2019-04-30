//
//  LanguageSettingTableViewController.m
//  LanguageSettingDemo
//
//  Created by 沈宸 on 4/30/19.
//  Copyright © 2019 Calvin. All rights reserved.
//

#import "LanguageSettingTableViewController.h"
#import "LanguageManager/LanguageManager.h"

@interface LanguageSettingTableViewController ()

@end

@implementation LanguageSettingTableViewController
+ (void)load{
    [[LanguageManager sharedInstance] setSupportLanguages:@[@"zh-Hans",@"en"]];
//    [LanguageManager sharedInstance].languageChangeBlock = ^{
//
//    };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = LanguageString(@"Language", @"LanguageSettingTableVC");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [LanguageManager sharedInstance].supportLanguages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseCell" forIndexPath:indexPath];
    if (indexPath.row) {
        cell.textLabel.text = LanguageString(@"en", @"LanguageSettingTableVC");
    }else{
        cell.textLabel.text = LanguageString(@"zh-Hans",@"LanguageSettingTableVC");
    }
    NSString *currentLanguage = [LanguageManager sharedInstance].currentLanguge;
    if([currentLanguage isEqualToString:[LanguageManager sharedInstance].supportLanguages[indexPath.row]]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        return;
    }
    for (UITableViewCell *acell in tableView.visibleCells) {
        acell.accessoryType = acell == cell ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    }
    
    if (indexPath.row) {
        [[LanguageManager sharedInstance] setCurrentLanguge:@"en"];
    }else{
        [[LanguageManager sharedInstance] setCurrentLanguge:@"zh-Hans"];
    }
    
    UINavigationController *navi = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"rootNavi"];
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"vc"];
    LanguageSettingTableViewController *tableVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"languagesettingVC"];
    navi.viewControllers = @[vc,tableVC];
    [UIApplication sharedApplication].keyWindow.rootViewController = navi;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
