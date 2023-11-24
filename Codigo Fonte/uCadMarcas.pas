unit uCadMarcas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UMasterCad, System.ImageList,
  Vcl.ImgList, Data.DB, Datasnap.DBClient, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons;

type
  TfrmCadMarcas = class(TMasterCad)
    Label1: TLabel;
    DbeIdProd: TDBEdit;
    Label2: TLabel;
    DbeMarca: TDBEdit;
    DbgMarca: TDBGrid;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadMarcas: TfrmCadMarcas;

implementation

{$R *.dfm}

uses uDmDados, UFerramentas, UVariaveis;

procedure TfrmCadMarcas.FormCreate(Sender: TObject);
begin
  inherited;
  Select_TabelaMaster(DmDados.CDMarcas, SQLs.Marcas, 'MARCAS', 'ID_MARCA', stManter_Dados);
  Pesquisa_Master := Ajustar_Pesquisa.Marcas;
end;

end.
