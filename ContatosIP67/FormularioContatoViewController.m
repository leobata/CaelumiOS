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
    if(self.contato){
        self.nome.text = self.contato.nome;
        self.telefone.text = self.contato.telefone;
        self.email.text = self.contato.email;
        self.endereco.text = self.contato.endereco;
        self.site.text = self.contato.site;
    }
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

- (void)criarContato
{
    Contato *contato = [self pegaDadosDoFormulario];
    //[self.contatos addObject:contato];
    [self.delegate contatoAdicionado:contato];
    NSLog(@"Contato adicionado: %@", contato);
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (Contato *)pegaDadosDoFormulario
{
    if(!self.contato){
        self.contato = [[Contato alloc] init];
    }
    self.contato.nome = self.nome.text;
    self.contato.endereco = self.endereco.text;
    self.contato.telefone = self.telefone.text;
    self.contato.email = self.email.text;
    self.contato.site = self.site.text;
    return self.contato;
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
- (id)initWithContato:(Contato *)contato
{
    self = [super init];
    if(self){
        self.contato = contato;
        self.navigationItem.title = @"Alteração";
        UIBarButtonItem *confirmButton = [[UIBarButtonItem alloc] initWithTitle:@"Confirma" style:UIBarButtonItemStylePlain target:self action:@selector(alterarContato)];
        self.navigationItem.rightBarButtonItem = confirmButton;
    }
    
    return self;
}

- (void)alterarContato
{
    [self pegaDadosDoFormulario];
    if([self.delegate respondsToSelector:@selector(contatoAlterado:)])
    {
        [self.delegate contatoAlterado:self.contato];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
