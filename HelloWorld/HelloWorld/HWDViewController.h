//
//  HWDViewController.h
//  HelloWorld
//
//  Created by ios4341 on 22/03/14.
//  Copyright (c) 2014 ios4341. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWDViewController : UIViewController

-(IBAction)mudaTexto:(id) sender;
-(IBAction)soma:(id) sender;
-(IBAction)sliderChanged:(UISlider *) sender;

@property (weak) IBOutlet UITextField *campoDeTexto;
@property (weak) IBOutlet UILabel *label;
@property (weak) IBOutlet UITextField *valor1;
@property (weak) IBOutlet UITextField *valor2;
@property (weak) IBOutlet UILabel *resultado;

@end
