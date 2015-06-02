//
//  ViewController.m
//  CSVParser
//
//  Created by Ha Minh Vuong on 8/31/12.
//  Copyright (c) 2012 Ha Minh Vuong. All rights reserved.
//

#import "ViewController.h"
#import "CSVParser.h"

@interface ViewController ()
@property (strong) NSArray *array;
@property (weak, nonatomic) IBOutlet UILabel *numberOfEntriesLabel;
@end

@implementation ViewController

@synthesize array = _array;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    NSString *file = [[NSBundle mainBundle] pathForResource:@"USPresident Wikipedia" ofType:@"csv"];
    
    // For Testing
    
//    [CSVParser parseCSVIntoArrayOfDictionariesFromFile:file
//                          withSeparatedCharacterString:@","
//                                  quoteCharacterString:nil
//                                             withBlock:^(NSArray *array, NSError *error) {
//                                                 self.array = array;
////                                                 NSLog(@"%@", self.array);
//                                                 self.numberOfEntriesLabel.text = [NSString stringWithFormat:@"%d", array.count];
//                                             }];
    
//    NSLog(@"%@", self.array);
    
//    [CSVParser parseCSVIntoArrayOfArraysFromFile:file
//                    withSeparatedCharacterString:@","
//                            quoteCharacterString:nil
//                                       withBlock:^(NSArray *array, NSError *error) {
//                                           self.array = array;
////                                           NSLog(@"%@", self.array);
//                                       }];
}

- (IBAction)showArray:(id)sender
{
//    NSLog(@"%@", self.array);
    NSString *file = [[NSBundle mainBundle] pathForResource:@"STRING_SATCOM" ofType:@"csv"];
    
  //  NSArray* fileArray = [CSVParser parseCSVIntoArrayOfDictionariesFromFile:file withSeparatedCharacterString:@"," quoteCharacterString:nil];

    [CSVParser parseCSVIntoArrayOfDictionariesFromFile:file
                          withSeparatedCharacterString:@","
                                  quoteCharacterString:@"\""
                                             withBlock:^(NSArray *array, NSError *error) {
                                                 self.array = array;
                                                 self.numberOfEntriesLabel.text = [NSString stringWithFormat:@"%d", array.count];
                                             }];
    
   
}

- (void)viewDidUnload
{
    [self setNumberOfEntriesLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
