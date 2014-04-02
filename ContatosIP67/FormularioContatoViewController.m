//
//  FormularioContatoViewController.m
//  ContatosIP67
//
//  Created by ios4341 on 29/03/14.
//  Copyright (c) 2014 Caelum. All rights reserved.
//

#import "FormularioContatoViewController.h"


@interface FormularioContatoViewController ()

@end

@implementation FormularioContatoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)init
{
    self = [super init];
    if (self) {
        self.navigationItem.title = @"Cadastro";
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Adiciona" style:UIBarButtonItemStylePlain target:self action:@selector(criarContato)];
        self.navigationItem.rightBarButtonItem = saveButton;
    }
    return self;
}

- (void) criarContato
{
    Contato *contato = [self pegaDadosDoFormulario];
    [self.contatos addObject:contato];
    
    NSLog(@"Contatos adicionados: %@", self.contatos);
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (Contato *)pegaDadosDoFormulario
{
    Contato *contato = [[Contato alloc] init];
    contato.nome = self.nome.text;
    contato.endereco = self.endereco.text;
    contato.telefone = self.telefone.text;
    contato.email = self.email.text;
    contato.site = self.site.text;
    return contato;
}

- (IBAction)proximoCampo:(UITextField *)sender
{
    NSInteger proximaTag = sender.tag+1;
    UIResponder *proximoCampo = [self.view viewWithTag:proximaTag];
    if(proximoCampo){
        [proximoCampo becomeFirstResponder];
    }
    else{
        [sender resignFirstResponder];
    }
}
@end
