#import "FibonacciResolver.h"

@implementation FibonacciResolver
- (int) fibo: (int) n{
    if (n == 0) {
        return 0;
    }else if (n == 1){
        return 1;
    }else{
        return ([self fibo:(n-1)] + [self fibo:(n-2)]);
    }
    
    
}
- (NSArray*)productFibonacciSequenceFor:(NSNumber*)number {
    NSLog(@"Fibonacci function is online ------------- %d", [self fibo:5]);
    int tempNumber = [number intValue];
    int i = 1;
    if (tempNumber > 2) {
        
        while (([self fibo:i]*[self fibo:(i-1)])<=tempNumber) {
            i++;
        }
    }
    if (([self fibo:(i-1)]*[self fibo:(i-2)]) == tempNumber) {
        return @[[NSNumber numberWithInt:[self fibo:(i-2)]], [NSNumber numberWithInt:[self fibo:(i-1)]], @1];
    }else{
        return @[[NSNumber numberWithInt:[self fibo:(i-1)]], [NSNumber numberWithInt:[self fibo:(i)]], @0];
        
    }
    
}
@end
