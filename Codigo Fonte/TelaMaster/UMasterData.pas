unit UMasterData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMaster, ComCtrls, jpeg, ExtCtrls, Buttons, StdCtrls;

type
  TMasterData = class(TMaster)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    btnOk: TSpeedButton;
    btnFechar: TSpeedButton;
    edtIni: TDateTimePicker;
    edtFim: TDateTimePicker;
    Image1: TImage;
    StatusBar1: TStatusBar;
    procedure btnFecharClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MasterData: TMasterData;

implementation

uses UFerramentas, UVariaveis;

{$R *.dfm}

procedure TMasterData.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TMasterData.btnOkClick(Sender: TObject);
begin
  if edtFim.Date < edtIni.Date then
  begin
    Aviso('A data final não pode ser menor que a data inicial');
    Exit;
  end
end;

procedure TMasterData.FormCreate(Sender: TObject);
var Ano, Mes, Dia : Word;
begin
  inherited;
  edtFim.Date := Date;
  DecodeDate(date,ano,mes,dia);
  edtIni.Date := edtFim.Date-Dia+1;
end;

end.
