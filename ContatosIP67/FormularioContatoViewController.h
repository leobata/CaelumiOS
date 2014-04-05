//
//  FormularioContatoViewController.h
//  ContatosIP67
//
//  Created by ios4341 on 29/03/14.
//  Copyright (c) 2014 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato.h"
#import "ListaContatosViewController.h"

@interface FormularioContatoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nome;
@property (weak, nonatomic) IBOutlet UITextField *telefone;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *endereco;
@property (weak, nonatomic) IBOutlet UITextField *site;
//@property (weak, atomic) NSMutableArray *contatos;
@property (weak, atomic) ListaContatosViewController *lista;
@property (strong, atomic) Contato *contato;
@property (weak, atomic) id<FormularioContatoViewControllerDelegate> delegate;
- (Contato *)pegaDadosDoFormulario;
- (IBAction)proximoCampo:(UITextField *)sender;
- (id)initWithContato:(Contato *)contato;
//BLABLABLA

@end
