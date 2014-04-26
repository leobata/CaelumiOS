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
#import <CoreLocation/CoreLocation.h>

@interface FormularioContatoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nome;
@property (weak, nonatomic) IBOutlet UITextField *telefone;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *endereco;
@property (weak, nonatomic) IBOutlet UITextField *site;
//@property (weak, atomic) NSMutableArray *contatos;
@property (weak, nonatomic) IBOutlet UITextField *latitude;
@property (weak, nonatomic) IBOutlet UITextField *longitude;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *rodinha;
@property (weak, atomic) ListaContatosViewController *lista;
@property (strong, atomic) Contato *contato;
@property (weak, atomic) id<FormularioContatoViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *botaoFoto;
@property (weak, nonatomic) IBOutlet UIButton *botaoLocation;
@property (weak, nonatomic) NSManagedObjectContext *context;
- (Contato *)pegaDadosDoFormulario;
-(IBAction)buscarCoordenadas:(id)sender;
- (id)initWithContato:(Contato *)contato;
//BLABLABLA

@end
