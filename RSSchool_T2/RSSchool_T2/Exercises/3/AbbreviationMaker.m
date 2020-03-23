#import "AbbreviationMaker.h"

@implementation AbbreviationMaker
// Complete the abbreviation function below.
- (NSString *) abbreviationFromA:(NSString *)a toB:(NSString *)b {
    
    NSMutableString *tempString;
    tempString = [a mutableCopy];
    int index = 0;
    
    while (index < [tempString length]){
        NSRange range = NSMakeRange(index, 1);
        if (index < [b length]){
            if ([[[tempString substringWithRange:range] uppercaseString] isEqualToString:[b substringWithRange:range]]) {
                index++;
            }else{
                if (!([[[tempString substringWithRange:range] uppercaseString] isEqualToString:[tempString substringWithRange:range]])) {
                    [tempString deleteCharactersInRange:range];
                }
            }
        }else{
            if (!([[[tempString substringWithRange:range] uppercaseString] isEqualToString:[tempString substringWithRange:range]])) {
                [tempString deleteCharactersInRange:range];
            }
        }
    };
    
    return ([[tempString uppercaseString] isEqualToString:b] ? @"YES" : @"NO");
}
@end
