//
//  TransitionTableViewController.m
//  Transition
//
//  Created by 杨雄 on 2019/7/4.
//  Copyright © 2019 shawn. All rights reserved.
//

#import "TransitionTableViewController.h"
#import "ModalNormalViewController.h"
#import "ModalInteractiveViewController.h"

@interface TransitionTableViewController ()

@end

@implementation TransitionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    
    switch (indexPath.row) {
        case 0: {
            ModalNormalViewController *vc = [[ModalNormalViewController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
        }
            break;
        case 1: {
            ModalInteractiveViewController *vc = [[ModalInteractiveViewController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}

@end
