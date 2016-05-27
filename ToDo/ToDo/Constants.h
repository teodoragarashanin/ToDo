//
//  Constants.h
//  ToDo
//
//  Created by Cubes School 5 on 4/15/16.
//  Copyright © 2016 Cubes School 5. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

//Macros

#define COLOR(r,g,b,a)      [UIColor colorWithRed: r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

// Colors

#define kOrangeColor        COLOR (254.0, 172.0, 73.0, 1.0)
#define kPurpleColor        COLOR (187.0, 114.0, 255.0, 1.0)
#define kTurquoiseColor     COLOR (72.0, 211.0, 194.0, 1.0)
#define kDescPlaceholderColor     COLOR (29.0, 29.0, 38.0, 1.0)

//Enums

typedef NS_ENUM (NSInteger, TaskGroup) {
    COMPLETED_TASK_GROUP =1,
    NOT_COMPLETED_TASK_GROUP,
    IN_PROGRESS_TASK_GROUP
};



// Notifications

static NSString *const CITY_CHANGED             =@"CITY_CHANGED";
static NSString *const SHOW_HOME                =@"SHOW_HOME";
static NSString *const SHOW_LOGIN                =@"SHOW_LOGIN";



//String and numbers

#define ZERO_VALUE      0.0

static NSString *const USER_IMAGE               = @"USER_NAME";
static NSString *const WALKTHROUGH_PRESENTED    = @"WALKTHROUGH_PRESENTED";
static NSString *const EMPTY_STRING              = @"";
static NSString *const OK_STRING                = @"OK";
static NSString *const LOGGED_IN                =@"LOGGED_IN";

//urls

static NSString *const CUBES_URL                =@"http://www.cubes.rs";





//SAMOSTALNI PROJEKAT

// 4,5 ekrana, 5 VC
// modalne push
// obavezno koristiti neki API ze nesto, kako integrisati third party, cocoa pods ??? npr google maps, ali nema networking
// obavezno pored third party biblioteke je obavezna komunikacija sa nekim web servisom, json npr networking
// integrisati Facebook i Twitter Google+, integracija yt mada on ide samo preko linka
// od 12 do 24
// av audio player za pustanje zvuka, ukoliko bude potrebno
// facebook for developers
// twiter ios sdk integration Fabric skinuti
// Google sign in nije vise google+
// mobile-patterns.com//
// obavezno git
// prezentacija aplikacije
// iconfinder
// u photoshopu da se dobiju sve tri rezolucije
// nasledjivanje npr tab bar, moze da se naslediiii!!! i onda mu promeniti karakteristiku
// side menu!!!!!!!!!!!

















#endif /* Constants_h */
