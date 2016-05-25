//
//  TaskTableViewCell.m
//  ToDo
//
//  Created by Cubes School 5 on 4/15/16.
//  Copyright © 2016 Cubes School 5. All rights reserved.
//

#import "TaskTableViewCell.h"
#import "Helpers.h"


@implementation TaskTableViewCell

#pragma mark - Properties

-(void) setTask:(Task *)task {
    
    _task=task;
    
    self.taskTitleLabel.text = task.title;
    self.taskDescriptionLabel.text = task.desc;
    self.taskGroupView.backgroundColor = [Helpers colorForTaskGroup:[task.group integerValue]];
    
}


@end