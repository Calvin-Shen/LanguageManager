//
//  ViewController.m
//  LanguageSettingDemo
//
//  Created by 沈宸 on 4/30/19.
//  Copyright © 2019 Calvin. All rights reserved.
//

#import "ViewController.h"
#import "LanguageManager/LanguageManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = LanguageString(@"HomePage", @"ViewController");
    
    self.imageView.image = [UIImage imageNamed:NSLocalizedString(@"testImage.jpg", nil)];
}


@end
