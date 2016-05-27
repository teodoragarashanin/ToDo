//
//  AppDelegate.m
//  ToDo
//
//  Created by Cubes School 5 on 3/28/16.
//  Copyright © 2016 Cubes School 5. All rights reserved.
//

#import "AppDelegate.h"
#import "DataManager.h"
#import <CoreLocation/CoreLocation.h>
#import "Helpers.h"
#import "UIViewController+Utilities.h"
#import "LogInViewController.h"
#import "SignUpViewController.h"
#import "HomeViewController.h"

@interface AppDelegate () <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@end
@implementation AppDelegate


#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [self registerForNotifications];
    [self configureLocationManager];
    
    if ([Helpers isLoggedIn]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:SHOW_HOME object:nil];
    }
    
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}



#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;



#pragma mark - Properties

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ToDo" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ToDo.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}


#pragma mark - Public API

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


#pragma mark - Private API

-(void)registerForNotifications {

    [[NSNotificationCenter defaultCenter] addObserverForName:SHOW_HOME object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        HomeViewController *homeViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([HomeViewController class])];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
        
        navigationController.navigationBarHidden = YES;
        
        self.window.rootViewController = navigationController;
        
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SHOW_LOGIN object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
       
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        LogInViewController *logInViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([LogInViewController class])];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:logInViewController];
        navigationController.navigationBarHidden = YES;
        
        self.window.rootViewController = navigationController;
        
        
        
    }];
    
    
}

-(void)configureLocationManager {
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startMonitoringSignificantLocationChanges];
    
}


#pragma mark - CLLocationManagerDelegate

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    if (locations.count >0) {
        [DataManager sharedInstance].userLocation = [locations firstObject];
    }
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog (@"Location manager error: %@", [error localizedDescription]);
    
}

@end