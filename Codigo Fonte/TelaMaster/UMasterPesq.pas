unit UMasterPesq;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UMaster, StdCtrls, Buttons, Grids, DBGrids, Db, DBClient, Mask, DBCtrls,
  ExtCtrls, Provider;

type

  TMasterPesq = class(TMaster)
    RGOpcoes: TRadioGroup;
    LbCampo: TLabel;
    DSPesquisa: TDataSource;
    CDPesquisa: TClientDataSet;
    EditPesquisa: TEdit;
    PGeral: TDataSetProvider;
    sbLocalizar: TSpeedButton;
    sbTodos: TSpeedButton;
    sbSair: TSpeedButton;
    DBGridPesquisa: TDBGrid;
    procedure RGOpcoesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGridPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure mascarar_nome;
    procedure EditPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditPesquisaChange(Sender: TObject);
    function PGeralDataRequest(Sender: TObject;
      Input: OleVariant): OleVariant;
    procedure sbLocalizarClick(Sender: TObject);
    procedure sbTodosClick(Sender: TObject);
    procedure sbSairClick(Sender: TObject);
    procedure DBGridPesquisaDblClick(Sender: TObject);
  private

  public

  end;

var
  MasterPesq  : TMasterPesq;
  SQL         : String;
implementation

uses UMasterCad, UFerramentas, UVariaveis, uPrincipal,
  Variants, uDmDados;

{$R *.DFM}

procedure TMasterPesq.FormCreate(Sender: TObject);
var
  i: Byte;
begin
  inherited;

  CDPesquisa.Close;
  SQL := ('SELECT ');
  for i := 0 to 3 do
    if Pesquisa_Master.Campos_Pesquisa[i] <> '' then
    begin
      RGOpcoes.Items.Add(Pesquisa_Master.Tab_Cliente.FieldByName
        (Pesquisa_Master.Campos_Pesquisa[i]).DisplayName);
      SQL := SQL + Pesquisa_Master.Campos_Pesquisa[i] + ',';
    end;

  SQL := Copy(SQL, 0, Length(SQL) - 1);
  SQL := SQL + ('  FROM ' + Pesquisa_Master.Tab_Banco);
  CDPesquisa.DataRequest(SQL + ' WHERE ' + Pesquisa_Master.Campos_Pesquisa[0] +
    ' IS NULL');
  CDPesquisa.Open;

  mascarar_nome;

  RGOpcoes.ItemIndex := 0;
  RGOpcoesClick(Sender);
  Self.Caption     := Pesquisa_Master.Titulo;
  //lblTitle.Caption := Pesquisa_Master.Titulo;

end;

procedure TMasterPesq.RGOpcoesClick(Sender: TObject);
begin
  inherited;
  LbCampo.Caption := RGOpcoes.Items.Strings[RGOpcoes.ItemIndex];
  try EditPesquisa.SetFocus
   Except;
   end;
end;

procedure TMasterPesq.mascarar_nome;
var
  i : Byte;
begin
  for i :=  0 to RGOpcoes.Items.Count -1 do
     DBGridPesquisa.Columns.Items[i].Title.Caption  := RGOpcoes.Items.Strings[i] ;
end;

procedure TMasterPesq.DBGridPesquisaDblClick(Sender: TObject);
begin
  inherited;
  if not(CDPesquisa.IsEmpty) then
  begin
    with Pesquisa_Master.Tab_Cliente do
    begin
      Close;
      DataRequest('SELECT * FROM ' + Pesquisa_Master.Tab_Banco + ' WHERE ' +
        Pesquisa_Master.Campos_Pesquisa[RGOpcoes.ItemIndex] + ' = ' +
        QuotedStr(CDPesquisa.FieldByName(Pesquisa_Master.Campos_Pesquisa
        [RGOpcoes.ItemIndex]).AsString));
      Open;
    end;
  end;
  Close;
end;

procedure TMasterPesq.DBGridPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13
     then sbSairClick(Sender);
end;

procedure TMasterPesq.EditPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = 13
     then sbLocalizarClick(Sender);
end;

procedure TMasterPesq.EditPesquisaChange(Sender: TObject);
var Condicao: String;
begin
begin
  if Pesquisa_Master.Condicao <> ''
    then Condicao := ' AND '+Pesquisa_Master.Condicao+' ';

  with CDPesquisa do begin
       Close;
       DataRequest(SQL + '  WHERE UPPER('+ Pesquisa_Master.Campos_Pesquisa[RGOpcoes.ItemIndex] +') LIKE UPPER('+
                   QuotedStr(EditPesquisa.Text+'%')+')' + Condicao + ' ORDER BY ' + Pesquisa_Master.Campos_Pesquisa[RGOpcoes.ItemIndex]);
            Open;
       mascarar_nome;
  end;

end;
end;
function TMasterPesq.PGeralDataRequest(Sender: TObject;
  Input: OleVariant): OleVariant;
begin
  DmDados.QGeral.SQL.Text := Input;
end;

procedure TMasterPesq.sbLocalizarClick(Sender: TObject);
var Condicao: String;
begin
  inherited;
  if EditPesquisa.Text = ''
     then begin
          sbTodosClick(Sender);
          Exit;
     end;
  if Pesquisa_Master.Condicao <> ''
    then Condicao := ' AND '+Pesquisa_Master.Condicao+' ';

  with CDPesquisa do begin
       Close;
       DataRequest(SQL + '  WHERE '+ Pesquisa_Master.Campos_Pesquisa[RGOpcoes.ItemIndex] +' >= "'+
                   EditPesquisa.Text + Condicao + '"  ORDER BY ' + Pesquisa_Master.Campos_Pesquisa[RGOpcoes.ItemIndex]);
       Open;
       mascarar_nome;
  end;

end;

procedure TMasterPesq.sbTodosClick(Sender: TObject);
var Condicao: String;
begin
  inherited;
  if Pesquisa_Master.Condicao <> ''
     then Condicao := ' Where ' + Pesquisa_Master.Condicao;

  with CDPesquisa do begin
       Close;
       DataRequest(SQL + Condicao + '  ORDER BY ' + Pesquisa_Master.Campos_Pesquisa[RGOpcoes.ItemIndex]);
       Open;
       mascarar_nome;
  end;
end;

procedure TMasterPesq.sbSairClick(Sender: TObject);
begin
  inherited;
  if not(CDPesquisa.IsEmpty)
     then begin
          with Pesquisa_Master.Tab_Cliente do begin
               Close;
               DataRequest('SELECT * FROM '+ Pesquisa_Master.Tab_BANCO +
                                    ' WHERE '+ Pesquisa_Master.Campos_Pesquisa[RGOpcoes.ItemIndex] +' = '+
                                    QuotedStr(CDPesquisa.FieldByName(Pesquisa_Master.Campos_Pesquisa[RGOpcoes.ItemIndex]).AsString ));
               Open;
          end;
     end;
  Close;
end;

end.
