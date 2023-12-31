unit UMasterCad;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UMaster, ImgList, ComCtrls, ToolWin, Db, DBClient, UVariaveis, stdctrls,
  extctrls, Buttons, System.ImageList, MidasLib, Vcl.Mask, Vcl.DBCtrls;

type
  TChecar_campos = record
                  Nome_Campo  : String;
                  STResultado : TPanel;
                  Mensagem    : String;
  end;

  TMasterCad = class(TMaster)
    DSTabelaMaster: TDataSource;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    TBApagar: TToolButton;
    TBLocalizar: TToolButton;
    TBSalvar: TToolButton;
    TBCancelar: TToolButton;
    ToolButton9: TToolButton;
    TBFechar: TToolButton;
    imgTab: TImageList;
    ilMasterCad: TImageList;
    TBEditar: TToolButton;
    TabelaMaster: TClientDataSet;
    BbtnPrior: TBitBtn;
    BtnNext: TBitBtn;
    TBImprimir: TToolButton;
    TBNovo: TToolButton;
    procedure ToolBar_Botoes( Inserindo : Boolean = True);
    procedure DSTabelaMasterStateChange(Sender: TObject);
    procedure Reseta_Tabela;
    procedure TBFecharClick(Sender: TObject);
    procedure Select_TabelaMaster(Tabela : TDataSet; SQL ,Tabela_Banco,Campo_Chave : String ; Resetar_Tabela : TSet_TabelaMaster);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Add_Checar_campos(Nome_Campo : String; STResultado : TPanel ; Mensagem : String = 'Erro' );
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure TBEditarClick(Sender: TObject);
    procedure BbtnPriorClick(Sender: TObject);
    procedure BtnNextClick(Sender: TObject);
    procedure TBNovoClick(Sender: TObject);
  private
    Resetar_Tabela : TSet_TabelaMaster;
    Master_SQL     : String;
  public
    Movimentacao     : Boolean ;
    Checar_campos    : Array [0..5]of TChecar_campos;
    I_Checar_campos  : Shortint;
    Chave            : String;
    Tb_Banco         : String;
  end;

var
  MasterCad: TMasterCad;

implementation

uses UFerramentas, UMasterPesq, uPrincipal, uDmDados;

{$R *.DFM}

procedure TMasterCad.ToolBar_Botoes( Inserindo : Boolean = True);
begin
  TBNovo .Enabled     := not Inserindo;
  TBEditar .Enabled   := not Inserindo;
  TBCancelar.Enabled  := Inserindo;
  TBApagar.Enabled    := (not Inserindo) and (not TabelaMaster.IsEmpty);
  TBSalvar.Enabled    := Inserindo;
  TBLocalizar.Enabled := not Inserindo;
  TBImprimir.Enabled  := not Inserindo;
  TBFechar.Enabled    := not Inserindo;
  BbtnPrior.Enabled   := not Inserindo;
  BtnNext.Enabled     := not Inserindo;
end;

procedure TMasterCad.BbtnPriorClick(Sender: TObject);
begin
  inherited;
  TabelaMaster.Prior;
end;

procedure TMasterCad.BtnNextClick(Sender: TObject);
begin
  inherited;
  TabelaMaster.Next;
end;

procedure TMasterCad.DSTabelaMasterStateChange(Sender: TObject);
begin
  inherited;
  ToolBar_Botoes(State_Insert(TabelaMaster));
end;

procedure TMasterCad.Reseta_Tabela;
begin
  if TabelaMaster <> nil then
   begin
    Desativar_Tabela(TabelaMaster);
    Ativar_Tabela(TabelaMaster,Master_SQL,Resetar_Tabela);
   end;
end;

procedure TMasterCad.TBEditarClick(Sender: TObject);
begin
  inherited;
  TabelaMaster.Edit;
end;

procedure TMasterCad.TBFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TMasterCad.TBNovoClick(Sender: TObject);
begin
  inherited;
  TabelaMaster.Append;
end;

procedure TMasterCad.Select_TabelaMaster(Tabela : TDataSet; SQL, Tabela_Banco,Campo_Chave : String ; Resetar_Tabela : TSet_TabelaMaster);
begin
  TabelaMaster              := TClientDataSet(Tabela);
  DSTabelaMaster.DataSet    := TabelaMaster;
  Master_SQL                := SQL;
  Ativar_Tabela(TabelaMaster,Master_SQL,Resetar_Tabela);
  case Resetar_Tabela of
       stResetar :  Reseta_Tabela;
  end;
  ToolBar_Botoes(False);
  Chave                     := Campo_Chave;
  Tb_Banco                  := Tabela_Banco;
end;

procedure TMasterCad.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if State_Insert(TabelaMaster) then
      if Confirma('Salvar o registro ?') then
          ToolButton8Click(Sender)
          else ToolButton6Click(Sender);
  if State_Insert(TabelaMaster) then
     Desativar_Tabela(TabelaMaster);
  inherited;
end;

procedure TMasterCad.FormCreate(Sender: TObject);
begin
  inherited;
  Movimentacao     := False;
  I_Checar_campos  := -1;
end;

procedure TMasterCad.Add_Checar_campos(Nome_Campo : String; STResultado : TPanel ; Mensagem : String = 'Erro' );
begin
 Inc(I_Checar_campos);
 Checar_campos[I_Checar_campos].Nome_Campo   := Nome_Campo;
 Checar_campos[I_Checar_campos].STResultado  := STResultado;
 Checar_campos[I_Checar_campos].Mensagem     := Mensagem;
end;

procedure TMasterCad.ToolButton7Click(Sender: TObject);
var
  Codigo_Retornar: Integer;
begin
  inherited;
  if Confirma('Excluir ?')  then
      begin
       with TabelaMaster do
        begin
         Codigo_Retornar := TabelaMaster.FieldByName(Chave).AsInteger;
         Delete;
         if ApplyUpdates(-1) <> 0 then
          begin
           Aviso('Exclus�o n�o efetuada!');
           UndoLastChange(True);
          end
           else Devolver_Codigo(Tb_Banco, Chave, Codigo_Retornar);
        end;
          case Resetar_Tabela of
           stResetar : Reseta_Tabela;
          end;
     end;

end;

procedure TMasterCad.ToolButton5Click(Sender: TObject);
begin
  inherited;
  MasterPesq := TMasterPesq.Create(Self);
  MasterPesq.ShowModal;
  MasterPesq.Free;
end;

procedure TMasterCad.ToolButton8Click(Sender: TObject);
var
  i : Byte;
begin
   if ValidaCamposTag(Self) = true then
    Exit;
  inherited;
  if not (I_Checar_campos < 0) then
    begin
     for i:= 0 to I_Checar_campos do
      if ((Trim(TabelaMaster.FieldByName(Checar_campos[i].Nome_Campo).AsString) <> '')
         and (Checar_campos[i].STResultado.Caption = '' )) then
          begin
           Erro(Checar_campos[i].Mensagem);
           TabelaMaster.Edit;
           ToolBar_Botoes;
           Exit;
          end;
    end;

  with TabelaMaster do
    begin
     if ApplyUpdates(-1) = 0 then
      begin
       ToolBar_Botoes;
       case Resetar_Tabela of
            stManter_Dados : if not(Movimentacao) then
            Reseta_Tabela;
       end;
       Informacao('Registro Salvo com Sucesso!');
       ToolBar_Botoes(False);
          end
          else
           begin
            Aviso('Grava��o n�o efetuada !');
            ToolBar_Botoes;
            Edit;
           end;
  end;

end;

procedure TMasterCad.ToolButton6Click(Sender: TObject);
begin
  inherited;
  TabelaMaster.CancelUpDates;
{  case Resetar_Tabela of
       stResetar        : Reseta_Tabela ;
  end; }
end;

procedure TMasterCad.ToolButton11Click(Sender: TObject);
begin
  inherited;
  Close;
end;

end.


