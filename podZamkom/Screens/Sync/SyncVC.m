//
//  SyncVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 29.01.14.
//  Copyright (c) 2014 Alexander Kraev. All rights reserved.
//

#import "SyncVC.h"


@interface SyncVC ()

@end

@implementation SyncVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad:[Translator languageSelectedStringForKey:@"SYNCHRONIZATION"]];
	// Do any additional setup after loading the view.
    
    self.dropboxSync.on = [Settings isLinkWithDropBox];
    
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    //скрываем кнопки создать копию и восстановить данные, если не было линковки с аккаунтом дропбокса:
    if (![self.dropboxSync isOn])
    {
        self.createBackupBtn.alpha = 0.0;
        self.restoreBackupBtn.alpha = 0.0;
        self.lblLastBackup.alpha = 0.0;
    }
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.dropboxSyncDelegate = self;
}

- (DBAccountManager *)manager {
    return [DBAccountManager sharedManager];
}

- (void)setButtonsVisibility:(BOOL)visible
{
    CGFloat alpha = 0.0;
    if (visible)
        alpha = 1.0;
    [UIView animateWithDuration:0.5
                          delay:0.2
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.createBackupBtn.alpha = alpha;
                         self.restoreBackupBtn.alpha = alpha;
                         self.lblLastBackup.alpha = alpha;
                     } 
                     completion:^(BOOL finished){
                     }];
}

- (void)linkingAccountFinished
{
    if ([Settings isLinkWithDropBox])
    {
        [self setButtonsVisibility:YES];
    }
    else
    {
        [self setButtonsVisibility:NO];
    }

}

- (IBAction)syncWithDropBox:(id)sender
{
    if ([self.dropboxSync isOn])
    {
        if (![Settings isLinkWithDropBox])
            [self.manager linkFromController:self];
        else
            [self setButtonsVisibility:YES];
    }
    else
    {
        
        [self.manager.linkedAccount unlink];
        [self setButtonsVisibility:NO];
    }
}

- (IBAction)createBackup:(id)sender
{
    /*
    DBAccount *account = [self.manager linkedAccount];
    
    if (account) {
        DBFilesystem *filesystem = [[DBFilesystem alloc] initWithAccount:account];
        [DBFilesystem setSharedFilesystem:filesystem];
    }*/
    
    [Sync WriteDataToBUFile:@"HELLO!"];
}

- (IBAction)restoreBackup:(id)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
