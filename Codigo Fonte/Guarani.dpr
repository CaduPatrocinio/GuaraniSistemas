program Guarani;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uDmDados in 'uDmDados.pas' {DmDados: TDataModule},
  UFerramentas in 'Ferramentas\UFerramentas.pas',
  UVariaveis in 'Ferramentas\UVariaveis.pas',
  UMaster in 'TelaMaster\UMaster.pas' {Master},
  UMasterCad in 'TelaMaster\UMasterCad.pas' {MasterCad},
  UMasterData in 'TelaMaster\UMasterData.pas' {MasterData},
  UMasterPesq in 'TelaMaster\UMasterPesq.pas' {MasterPesq},
  uCadMarcas in 'uCadMarcas.pas' {frmCadMarcas},
  uCadProdutos in 'uCadProdutos.pas' {frmCadProdutos},
  uCadClientes in 'uCadClientes.pas' {frmCadClientes},
  uPedido in 'uPedido.pas' {frmCadPedido},
  uRelProdVendidos in 'uRelProdVendidos.pas' {frmRelProdVendidos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDmDados, DmDados);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
