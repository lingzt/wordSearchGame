//
//  ViewController.m
//  wordSearchGame
//
//  Created by ling toby on 6/2/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
/*
 Build an application that allows the user to play a word search game
 Your app should generate a random string of text displayed as a square
 Your app should allow the user to search the string for words, and should give the user a point each time they find a word
 Your app should show a running list of words the user has found on the screen
 Bonus: The user should only receive points for actual words, not any string of letters that appears in the random string
 */

#import "ViewController.h"

@interface ViewController ()

@end

//MARK: - Properties
@implementation ViewController
NSArray *wordArr;
NSMutableArray *singleStringArr;
NSMutableArray *mixArr;
NSString *userInput;
int anIndex;
int score =0;

//MARK: - Life Cycle Methods
- (void)viewDidLoad {
    _storeBoard.text = [NSString stringWithFormat:@"%i points", score];
    [super viewDidLoad];
    [self initWordArr];
    [self generateSingleStringArr];
    [self generateMixArr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK: - Interactivity Methods
    //1. init word arr
-(void)initWordArr{
    wordArr = @[@"jimson", @"string", @"letters", @"that",@"appears", @"random"];
}

    //2. generate singleStringArr
-(void)generateSingleStringArr{
    singleStringArr = [NSMutableArray arrayWithObjects:nil];
    NSString *toDisplay;
    for(int i = 0; i < 350; i++){
        NSString *randomLetter = [self getRandomCharAsNString];
        [singleStringArr addObject:randomLetter];
//        toDisplay = [NSString stringWithFormat:@"%@%@",toDisplay,randomLetter];
//        _searchBox.text = toDisplay;
    }
}
    //2.2 get Random Char As NString
- (NSString *)getRandomCharAsNString {
    return [NSString stringWithFormat:@"%c", arc4random_uniform(26) + 'a'];
}

    //3. generate random index < singleStringArr.count, place word arr into singleStringArr to mixArr
-(void)generateMixArr{
    mixArr = singleStringArr;
    int n = singleStringArr.count;
    for (int i = 0; i < wordArr.count; i++) {
        int indexToBeReplaced = arc4random_uniform(n);
        [mixArr replaceObjectAtIndex:indexToBeReplaced withObject:wordArr[i]];
    }
    NSLog(@"%@", mixArr.description);
    
    NSString *stringToDisplay = @"";
    for (int i = 0; i < mixArr.count; i++) {
        NSString *stringToAdd = mixArr[i];
        stringToDisplay = [NSString stringWithFormat:@"%@%@",stringToDisplay, stringToAdd];
    }
    _searchBox.text = stringToDisplay;

}



- (IBAction)searchWord:(UIButton *)sender {
    userInput =_inputTextField.text;
    int anIndex = [mixArr indexOfObject:userInput];
    if (NSNotFound == anIndex){
        score --;
        _storeBoard.text = [NSString stringWithFormat:@"%i points", score];
    }else{
        score++;
        _storeBoard.text = [NSString stringWithFormat:@"%i points", score];
    }
    

    
    
}

@end
