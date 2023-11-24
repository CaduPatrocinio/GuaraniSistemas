unit uRelProdVendidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UMaster, Data.DB, IBX.IBCustomDataSet,
  IBX.IBStoredProc, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmRelProdVendidos = class(TMaster)
    DbgProduto: TDBGrid;
    DsProd: TDataSource;
    SpProd: TIBStoredProc;
    SpProdDESCRICAO: TIBStringField;
    SpProdTOTAL: TIntegerField;
    RadioGroup1: TRadioGroup;
    DtInicial: TDateTimePicker;
    DtFinal: TDateTimePicker;
    btnPesq: TBitBtn;
    btnSair: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelProdVendidos: TfrmRelProdVendidos;

implementation

{$R *.dfm}

uses uDmDados, UFerramentas;

procedure TfrmRelProdVendidos.BitBtn1Click(Sender: TObject);
begin
  inherited;
  if DtInicial.Date > DtFinal.Date then
   begin
     Aviso('A data icinial não pode ser maior que a data final!');
     exit;
   end;

  with SpProd do
   begin
    Prepare;
    Params[0].AsDate := DtInicial.Date;
    Params[1].AsDate := DtFinal.Date;
    Prepare;
    ExecProc();
   end;

  if SpProd.RecordCount = 0 then
   Informacao('Nenhum registro encontrado!')


end;

procedure TfrmRelProdVendidos.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
