//
//  FormularioContatoViewControllerDelegate.h
//  ContatosIP67
//
//  Created by ios4341 on 05/04/14.
//  Copyright (c) 2014 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contato.h"

@protocol FormularioContatoViewControllerDelegate <NSObject>

-(void)contatoAdicionado:(Contato *) contato;
@optional
-(void)contatoAlterado:(Contato *) contato;

@end
