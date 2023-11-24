unit uCadClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UMasterCad, Data.DB, Datasnap.DBClient,
  System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.Mask, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

type
  TfrmCadClientes = class(TMasterCad)
    Label1: TLabel;
    DbeCodCli: TDBEdit;
    Label2: TLabel;
    DbeNFantasia: TDBEdit;
    Label3: TLabel;
    DbeRSocial: TDBEdit;
    Label4: TLabel;
    DbeCNPJ: TDBEdit;
    Label5: TLabel;
    DbeCEP: TDBEdit;
    Label6: TLabel;
    DbeEndereco: TDBEdit;
    Label7: TLabel;
    DbeNum: TDBEdit;
    Label8: TLabel;
    DbeBairro: TDBEdit;
    Label9: TLabel;
    DbeCidade: TDBEdit;
    Label10: TLabel;
    DbeUF: TDBEdit;
    Label11: TLabel;
    DbeTel: TDBEdit;
    DBGridPesquisa: TDBGrid;
    IdConsCEP: TIdHTTP;
    procedure FormCreate(Sender: TObject);
    procedure DbeCEPChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadClientes: TfrmCadClientes;

implementation

{$R *.dfm}

uses uDmDados, UFerramentas, UVariaveis;

procedure TfrmCadClientes.DbeCEPChange(Sender: TObject);
var
  Endereco: TStringList;
begin
  inherited;
  if (Trim(DbeCEP.Text) <> '') And (DmDados.CDClientes.State in [dsInsert, dsEdit]) then
   begin
    Endereco:=TStringList.Create;
    Endereco.text := Stringreplace(IdConsCEP.URL.URLDecode(IdConsCEP.Get('http://republicavirtual.com.br/web_cep.php?cep='+DbeCEP.text+'&formato=query_string')),'&',#13#10,[rfreplaceAll]);
    if trim(Endereco.text) <> '' then
     begin
      DmDados.CDClientesENDERECO.AsString := Endereco.Values['TIPO_LOGRADOURO']+' '+ Endereco.Values['LOGRADOURO'];
      DmDados.CDClientesBAIRRO.AsString := Endereco.Values['BAIRRO'];
      DmDados.CDClientesCIDADE.AsString := Endereco.Values['CIDADE'];
      DmDados.CDClientesUF.AsString  := Endereco.Values['UF']
     end;
 end;
end;

procedure TfrmCadClientes.FormCreate(Sender: TObject);
begin
  inherited;
  Select_TabelaMaster(DmDados.CDClientes, SQLs.Clientes, 'CLIENTES', 'ID_CLIENTE', stManter_Dados);
  Pesquisa_Master := Ajustar_Pesquisa.Clientes;
end;

end.
