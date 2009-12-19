@implementation NSDate (Extend)

- (BOOL)isBetweenDate:(NSDate *)dateStart andDate:(NSDate *)dateEnd {
	if ([self compare:dateEnd] == NSOrderedDescending)
		return NO;
	
	if ([self compare:dateStart] == NSOrderedAscending) 
		return NO;
	
	return YES;
}

@end