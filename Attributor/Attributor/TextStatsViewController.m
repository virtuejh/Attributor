//
//  TextStatsViewController.m
//  Attributor
//
//  Created by JAE LEE on 12/12/13.
//  Copyright (c) 2013 JAE LEE. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharatersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;
@end

@implementation TextStatsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.textToAnalyze = [[NSAttributedString alloc]initWithString:@"tests" attributes:@{NSForegroundColorAttributeName : [UIColor greenColor],NSStrokeWidthAttributeName :@-3}];
    
}

- (void)setTextAnalyze:(NSAttributedString *)textToAnalyze
{
    _textToAnalyze = textToAnalyze;
    if (self.view.window) [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void) updateUI
{
    self.colorfulCharatersLabel.text = [NSString stringWithFormat:@"%d colorful characters",[[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%d outlined characters",[[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];
}

- (NSAttributedString *)charactersWithAttribute:(NSString *)attributeName
{
    NSMutableAttributedString *charaters = [[NSMutableAttributedString alloc]init];
    
    int index = 0;
    
    while (index < [self.textToAnalyze length]) {
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if(value){
            [charaters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = range.location + range.length;
        }else{
            index++;
        }
    }
    return charaters;
}

@end
