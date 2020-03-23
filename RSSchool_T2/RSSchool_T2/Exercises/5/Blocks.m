#import "Blocks.h"

@implementation Blocks

__weak NSObject *result = nil;
__weak NSArray *inputArray = nil;
__weak Class inputClas = nil;

-(NSObject *) operationWithArray: (NSObject * (^)(NSObject *, NSObject *)) operationBlock{
    NSObject *tempObject;
    int startIndex = 0;
    
    if ([inputArray count] > 0) {
        while (!([inputArray[startIndex] isKindOfClass:inputClas]) && (startIndex < [inputArray count])) {
            startIndex ++;
        }
        if ([inputArray[startIndex] isKindOfClass:inputClas]){
            tempObject = inputArray[startIndex];
        }else{
            return @[];
        }
        for (int i = startIndex+1; i < [inputArray count]; i++) {
            if ([inputArray[i] isKindOfClass: inputClas]){
                tempObject = operationBlock(tempObject, inputArray[i]);
            }
        }
        return tempObject;
    } else{
        return @[];
    }
    
}
-(void) handleBlock {
    
    typedef NSObject* (^OperationBlockType) (NSObject*, NSObject*);
    OperationBlockType  operationBlock;
    if (inputClas == [NSString class]) {
        
        operationBlock = ^NSObject* (NSObject* leftMember, NSObject *rightMember){
            return [leftMember stringByAppendingString:rightMember];
        };
        
    } else if (inputClas == [NSNumber class]){
        operationBlock = ^NSObject* (NSObject* leftMember, NSObject *rightMember){
            return ([NSNumber numberWithInt: [leftMember intValue] + [rightMember intValue]]);
        };
        
    }else if (inputClas == [NSDate class]){
        operationBlock = ^NSObject* (NSObject* leftMember, NSObject *rightMember){
            return ([leftMember compare: rightMember] == NSOrderedDescending) ? leftMember : rightMember;
            
        };
    }
    if ((inputArray != nil) && (inputClas != nil)){
        result = [self operationWithArray:operationBlock];
        if ([result isKindOfClass: [NSDate class]]){
            NSDate *tempResult;
            tempResult = [result copy];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd.MM.yyyy"];
            result = [dateFormatter stringFromDate: tempResult];
        }
        
        self.blockC(result);
        
    }
    result = nil;
    inputClas = nil;
    
}

-(BlockA) blockA  {
    return Block_copy (^(NSArray *array){
        inputArray = array;
        [self handleBlock];
        NSLog(@"I am blockA");
    });
}

-(BlockB) blockB {
    return Block_copy (^(Class class){
        inputClas = class;
        [self handleBlock];
        NSLog(@"I am blockB");
    });
}

@end

