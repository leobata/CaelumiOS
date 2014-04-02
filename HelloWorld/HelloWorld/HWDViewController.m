//
//  HWDViewController.m
//  HelloWorld
//
//  Created by ios4341 on 22/03/14.
//  Copyright (c) 2014 ios4341. All rights reserved.
//

#import "HWDViewController.h"

@interface HWDViewController ()

@end

@implementation HWDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)mudaTexto:(id)sender
{
    NSString *textoDigitado = self.campoDeTexto.text;
    self.label.text = textoDigitado;
}

-(IBAction)soma:(id)sender
{
    NSInteger valor1 = [self.valor1.text integerValue];
    NSInteger valor2 = [self.valor2.text integerValue];
    NSString *strResultado = [[NSString alloc] initWithFormat: @"%d", valor1+valor2];
    self.resultado.text = strResultado;
}

-(void)sliderChanged:(UISlider *)sender
{
    NSString *strValor = [NSString stringWithFormat: @"%.2f", sender.value];
    if (sender.tag == 1) {
        self.valor1.text = strValor;
    } else {
        self.valor2.text = strValor;
    }
    
}

@end
