//
//  QuickTimerViewController.m
//  RunTime
//
//  Created by HMC on 2/24/14.
//  Copyright (c) 2014 HMC. All rights reserved.
//

#import "QuickTimerViewController.h"

@interface QuickTimerViewController ()

@end

@implementation QuickTimerViewController

int secValue = 30;
int secCountDown = 30;
BOOL started = NO;

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
    [super viewDidLoad];
    self.timerSec.text = [NSString stringWithFormat:@"%d", secValue];
	
}

-(void)updateTimer:(NSTimer *)timer {
    self.timerSec.text = [NSString stringWithFormat:@"%d", --secCountDown];
}

- (IBAction)beginTimer:(id)sender {
    if (!started) {
        self.quickTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                           target:self
                                                         selector:@selector(updateTimer:)
                                                         userInfo:nil
                                                          repeats:YES];
        
        NSRunLoop *runner = [NSRunLoop currentRunLoop];
        [runner addTimer: self.quickTimer forMode: NSDefaultRunLoopMode];
        [_startTimer setTitle:@"Pause" forState:UIControlStateNormal];
        started = YES;
    }
    else {
        [sender setTitle:@"Start" forState:UIControlStateNormal];
        started = NO;
        if(_quickTimer){
            [_quickTimer invalidate];
            _quickTimer = nil;
        }
    }

}

- (IBAction)resetTimer:(id)sender {
    if(_quickTimer){
        [_quickTimer invalidate];
        _quickTimer = nil;
    }
    _timerSec.text = [NSString stringWithFormat:@"%d", secValue];
    secCountDown = secValue;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
