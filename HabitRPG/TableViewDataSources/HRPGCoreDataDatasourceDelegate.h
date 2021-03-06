//
//  HRPGCoreDataDatasourceDelegate.h
//  Habitica
//
//  Created by Phillip Thelen on 04/08/16.
//  Copyright © 2017 HabitRPG Inc. All rights reserved.
//

#ifndef HRPGCoreDataDatasourceDelegate_h
#define HRPGCoreDataDatasourceDelegate_h

@protocol HRPGCoreDataDataSourceDelegate

- (BOOL)canEditRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)deleteItemAtIndexPath:(NSIndexPath *)indexPath;

@end


#endif /* HRPGCoreDataDatasourceDelegate_h */
