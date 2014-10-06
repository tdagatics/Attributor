//
//  TextStatsViewController.m
//  Attributor
//
//  Created by Anthony Dagati on 10/6/14.
//  Copyright (c) 2014 Black Rail Capital. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()

@property (strong, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;

@property (strong, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;

@end

@implementation TextStatsViewController

-(void)setTextToAnalyze:(NSAttributedString *)textToAnalyze
{
    textToAnalyze = textToAnalyze;
    if (self.view.window) {
        [self updateUI]; // If on screen, update, otherwise let viewWillAppear do it
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
    
    
}

-(void)updateUI
{
    self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%d colorful characters", [[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%d colorful characters", [[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];
    
    
}

-(NSAttributedString *)charactersWithAttribute:(NSString *)attributeName
{
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    int index = 0;
    while (index < [self.textToAnalyze length]) {
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if (value) {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = range.location + range.length;
        } else {
            index++;
        }
        
    }
    
    return characters;
    
}

@end
