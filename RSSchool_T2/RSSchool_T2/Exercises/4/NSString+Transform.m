#import "NSString+Transform.h"

@implementation NSString (Transform)
NSMutableSet *setOfVowels;
NSMutableSet *setOfConsonants;
-(NSMutableString *) deleteInvalidSpaces: (NSMutableString *) tempString{
    
    int startIndex = 0;
    while (([[tempString substringWithRange:NSMakeRange(startIndex, 1)] isEqualToString: @" "])&&([tempString length]>0)) {
        
        [tempString deleteCharactersInRange:NSMakeRange(startIndex, 1)];
        if ([tempString length] == 0) {
            return [NSMutableString stringWithFormat:@"%@", @""];
        }
    }
    startIndex = [tempString length] - 1;
    while (([[tempString substringWithRange:NSMakeRange(startIndex, 1)] isEqualToString: @" "])&&([tempString length]>0)) {
        [tempString deleteCharactersInRange:NSMakeRange(startIndex, 1)];
        startIndex = [tempString length] - 1;
        
    }
    return tempString;
}
-(NSString*) generateWord: (NSString*) string with: (NSSet*) setOfLetters{
    int counter = 0;
    NSMutableString *tempString;
    tempString = [NSMutableString new];
    for (int i = 0; i<[string length]; i++) {
        if  ([setOfLetters containsObject: [[string substringWithRange:NSMakeRange(i, 1)] uppercaseString]]){
            counter ++;
            [tempString appendString:[[string substringWithRange:NSMakeRange(i, 1)] uppercaseString]];
        }else{
            [tempString appendString:[string substringWithRange:NSMakeRange(i, 1)]];
            
        }
    }
    [tempString insertString:[NSString stringWithFormat:@"%d", counter] atIndex:0];
    return tempString;
}
-(NSString*) handleString:(NSString *) string with: (NSSet *) setOfLetters {
    NSMutableString *tempString = [string mutableCopy];
    NSMutableArray *tempArray = [NSMutableArray new];
    NSString *wordInString;
    int startIndex = 0;
    tempString = [self deleteInvalidSpaces:tempString];
    if ([tempString length] == 0) {
        return @"";
    }
    int i = 0;
    while (i < [tempString length]) {
        if ([[tempString substringWithRange:NSMakeRange(i, 1)] isEqualToString: @" "]){
            wordInString = [tempString substringWithRange:NSMakeRange(startIndex, i-startIndex)];
            [tempArray addObject:[self generateWord:wordInString with:setOfLetters]];
            
            while (([[tempString substringWithRange:NSMakeRange(i, 1)] isEqualToString: @" "])) {
                i++;
            }
            startIndex = i;
        }else{
            i++;
        }
        
    }
    wordInString = [tempString substringWithRange:NSMakeRange(startIndex, [tempString length] - startIndex)];
    [tempArray addObject:[self generateWord:wordInString with:setOfLetters]];
    [tempArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [[obj1 substringWithRange:NSMakeRange(0, 1)] caseInsensitiveCompare:[obj2 substringWithRange:NSMakeRange(0, 1)]];
    }];
    tempString = nil;
    tempString = [NSMutableString new];
    for (int i = 0; i < [tempArray count]; i++) {
        [tempString appendString:tempArray[i]];
        [tempString appendString:@" "];
    }
    [tempString deleteCharactersInRange:NSMakeRange([tempString length]-1, 1)];
    return tempString;
}

-(BOOL) isPangram: (NSString *) string{
    NSMutableSet *setOfAlphabet;
    
    setOfAlphabet = [NSMutableSet new];
    for (char i = 65; i <= 90; i++) {
        [setOfAlphabet addObject: [NSString stringWithFormat:@"%c",i]];
        if ((i == 65) || (i == 69) || (i == 73) || (i == 79) || (i == 85) || (i == 89)){
            [setOfVowels addObject: [NSString stringWithFormat:@"%c",i]];
        }else{
            [setOfConsonants addObject: [NSString stringWithFormat:@"%c",i]];
            
        }
    }
    
    for (int i = 0; i<[string length]; i++){
        if ([setOfAlphabet containsObject: [[string substringWithRange:NSMakeRange(i, 1)] uppercaseString]]) {
            [setOfAlphabet removeObject:[[string substringWithRange:NSMakeRange(i, 1)] uppercaseString]];
        }
    }
    return ([setOfAlphabet count] == 0);
}

-(NSString*)transform {
    setOfVowels = [NSMutableSet new];
    setOfConsonants = [NSMutableSet new];
    NSString *tempString = [self mutableCopy];
    if ([self isPangram:tempString]) {
        tempString = [self handleString: tempString with: setOfVowels];
    }else{
        tempString = [self handleString: tempString with: setOfConsonants];
        
    }
    return tempString;
}

@end
