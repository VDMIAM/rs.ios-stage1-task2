#import "Dates.h"

@implementation Dates
-(NSString *) onRussian: (NSString *)elementOfDate{
    NSDictionary * dict = @{@"January":@"января",
                            @"February":@"февраля",
                            @"March":@"марта",
                            @"April":@"апреля",
                            @"May":@"мая",
                            @"June":@"июня",
                            @"July":@"июля",
                            @"August":@"августа",
                            @"September":@"сентября",
                            @"October":@"октября",
                            @"November":@"ноября",
                            @"December":@"декабря",
                            @"Monday":@"понедельник",
                            @"Tuesday":@"вторник",
                            @"Wednesday":@"среда",
                            @"Thursday":@"четверг",
                            @"Friday":@"пятница",
                            @"Saturday":@"суббота",
                            @"Sunday":@"воскресенье"
                            };
    return dict[elementOfDate];
}
- (NSString *)textForDay:(NSString *)day month:(NSString *)month year:(NSString *)year {
    NSString *tempString = [NSString new];
    NSString *weekDay = [NSString new];
    NSString *monthName = [NSString new];
    NSDate *tempDate = [NSDate new];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    tempString = [NSString stringWithFormat:@"%@.%@.%@",day,month,year];
    tempDate = [dateFormatter dateFromString:tempString];
    [dateFormatter setDateFormat:@"EEEE"];
    weekDay = [dateFormatter stringFromDate:tempDate];
    [dateFormatter setDateFormat:@"MMMM"];
    monthName = [dateFormatter stringFromDate:tempDate];
    
    
    if (tempDate){
        return [NSString stringWithFormat: @"%@ %@, %@",day,[self onRussian:monthName],[self onRussian:weekDay]];
    }else{
        return @"Такого дня не существует";
    }
    
}

@end
