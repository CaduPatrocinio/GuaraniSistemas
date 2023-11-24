unit uCadProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UMasterCad, System.ImageList,
  Vcl.ImgList, Data.DB, Datasnap.DBClient, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids;

type
  TfrmCadProdutos = class(TMasterCad)
    Label1: TLabel;
    DbeCodProd: TDBEdit;
    Label2: TLabel;
    DbeCodMarca: TDBEdit;
    Label3: TLabel;
    DbeDescProd: TDBEdit;
    Label4: TLabel;
    DbePreco: TDBEdit;
    PnMarca: TPanel;
    DbgProduto: TDBGrid;
    SbLocMarca: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure SbLocMarcaClick(Sender: TObject);
    procedure DbeCodMarcaChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadProdutos: TfrmCadProdutos;

implementation

{$R *.dfm}

uses uDmDados, UFerramentas, UVariaveis, UMasterPesq;

procedure TfrmCadProdutos.DbeCodMarcaChange(Sender: TObject);
begin
  inherited;
  Retornar_Dados('MARCAS','ID_MARCA',DbeCodMarca.Text,'MARCA', PnMarca, PnMarca);
end;

procedure TfrmCadProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  Select_TabelaMaster(DmDados.CDProdutos, SQLs.Produtos, 'PRODUTOS', 'ID_PRODUTO', stManter_Dados);
  Pesquisa_Master := Ajustar_Pesquisa.Produtos;
end;

procedure TfrmCadProdutos.SbLocMarcaClick(Sender: TObject);
begin
  inherited;
  Pesquisa_Master := Ajustar_Pesquisa.Marcas;
  if State_Insert(DmDados.CDProdutos) then
   begin
    DmDados.CDProdutosID_MARCA.AsInteger  := Pesquisa_Master.Tab_Cliente.FieldByName('ID_MARCA').AsInteger;
    MasterPesq := TMasterPesq.Create(Self);
    Pesquisa_Master := Ajustar_Pesquisa.Marcas;
    MasterPesq.ShowModal;
    MasterPesq.Free;
   end;
  Pesquisa_Master := Ajustar_Pesquisa.Marcas;
end;

end.                                          
