#import "TimeConverter.h"

@implementation TimeConverter
// Complete the following function

-(NSString *) inWords: (NSString *) string{
    NSDictionary *tempDict = @{@1:@"one",
                               @2:@"two",
                               @3:@"three",
                               @4:@"four",
                               @5:@"five",
                               @6:@"six",
                               @7:@"seven",
                               @8:@"eight",
                               @9:@"nine",
                               @10:@"ten",
                               @11:@"eleven",
                               @12:@"tvelwe",
                               @13:@"thirteen",
                               @14:@"fourteen",
                               @15:@"quarter",
                               @16:@"sixteen",
                               @17:@"seventeen",
                               @18:@"eighteen",
                               @19:@"nineteen",
                               @20:@"twenty",
                               @21:@"twenty one",
                               @22:@"twenty two",
                               @23:@"twenty three",
                               @24:@"twenty four",
                               @25:@"twenty five",
                               @26:@"twenty six",
                               @27:@"twenty seven",
                               @28:@"twenty eight",
                               @29:@"twenty nine",
                               @30:@"half",
                               @0:@"zero"
                               };
    int temp = [string intValue];
    return tempDict[[NSNumber numberWithInt:temp]];
}
- (NSString*)convertFromHours:(NSString*)hours minutes:(NSString*)minutes {
    NSMutableString *tempString = [NSMutableString new];
    
    if ([minutes integerValue]==0) {
        if ([hours integerValue]==15) {
            return @"fifteen o' clock";
        }else{
            return [NSString stringWithFormat:@"%@ o' clock", [self inWords:hours]];
        }
    }else{
        if (([hours integerValue]>=0) && ([hours integerValue]<24) && ([minutes integerValue]>=0) && [minutes integerValue]<60) {
            if ([minutes integerValue]<=30) {
                if ([hours integerValue]==15) {
                    return [NSString stringWithFormat:@"%@ o' clock", [self inWords:hours]];
                }else{
                    if ([minutes integerValue]<=30) {
                        NSString *minute = ([minutes integerValue] == 1) ? @" minute " : @" minutes ";
                        minute = (([minutes integerValue] == 15) ||([minutes integerValue] == 30)) ? @" " : minute;
                        return [NSString stringWithFormat:@"%@%@past %@", [self inWords:minutes], minute, [self inWords:hours]];
                    }
                }
            }else{
                if ([hours integerValue]==15) {
                    return [NSString stringWithFormat:@"%@ o' clock", [self inWords:hours]];
                }else{
                    
                    NSString *minute = ([minutes integerValue] == 1) ? @" minute " : @" minutes ";
                    NSString *tempMinutes = [NSString stringWithFormat:@"%d", (60 - [minutes intValue])];
                    NSString *tempHours = ([hours intValue] == 23) ? @"00" : [NSString stringWithFormat:@"%d",[hours intValue]+1];
                    minute = ((60 - [minutes integerValue]) == 15) ? @" " : minute;
                    
                    return [NSString stringWithFormat:@"%@%@to %@", [self inWords:tempMinutes], minute, [self inWords:tempHours]];
                    
                }
            }
        }else{
            return @"";
        }
    }
    
    
    return @"";
}
@end
