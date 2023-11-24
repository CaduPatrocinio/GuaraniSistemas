unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage;

type
  TfrmPrincipal = class(TForm)
    Image1: TImage;
    StatusBar1: TStatusBar;
    MmPrincipal: TMainMenu;
    Cadastro1: TMenuItem;
    Marcas1: TMenuItem;
    Clientes1: TMenuItem;
    N1: TMenuItem;
    Produtos1: TMenuItem;
    Pedido1: TMenuItem;
    Pedidos1: TMenuItem;
    Relatrios1: TMenuItem;
    Produtosmaisvendidos1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Marcas1Click(Sender: TObject);
    procedure Produtos1Click(Sender: TObject);
    procedure Clientes1Click(Sender: TObject);
    procedure Pedidos1Click(Sender: TObject);
    procedure Produtosmaisvendidos1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uDmDados, UFerramentas, UVariaveis, uCadMarcas, uCadProdutos, uCadClientes,
  uPedido, uRelProdVendidos;

procedure TfrmPrincipal.Clientes1Click(Sender: TObject);
begin
  frmCadClientes := TfrmCadClientes.Create(Self);
  frmCadClientes.ShowModal;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
with Ajustar_Pesquisa do
  begin
    Clientes := Definir_Pesquisa(DmDados.CdClientes, 'CLIENTES', 'Pesquisa Clientes', 'ID_CLIENTE', 'NOME_FANTASIA', 'RAZAO_SOCIAL');
    Marcas   := Definir_Pesquisa(DmDados.CdMarcas, 'MARCAS', 'Pesquisa Marcas', 'ID_MARCA', 'MARCA');
    Pedidos  := Definir_Pesquisa(DmDados.CDPedido, 'PEDIDO', 'Pesquisa Pedidos ', 'ID_PEDIDO');
    Produtos := Definir_Pesquisa(DmDados.CDProdutos, 'PRODUTOS', 'Pesquisa produtos',  'ID_PRODUTO', 'DESCRICAO');
  end;
end;

procedure TfrmPrincipal.Marcas1Click(Sender: TObject);
begin
  frmCadMarcas := TfrmCadMarcas.Create(Self);
  frmCadMarcas.ShowModal;
end;

procedure TfrmPrincipal.Pedidos1Click(Sender: TObject);
begin
  frmCadPedido := tfrmCadPedido.Create(Self);
  frmCadPedido.ShowModal;
end;

procedure TfrmPrincipal.Produtos1Click(Sender: TObject);
begin
  frmCadProdutos := tfrmCadProdutos.Create(Self);
  frmCadProdutos.ShowModal;
end;

procedure TfrmPrincipal.Produtosmaisvendidos1Click(Sender: TObject);
begin
  frmRelProdVendidos := tfrmRelProdVendidos.Create(Self);
  frmRelProdVendidos.ShowModal;
end;

end.
