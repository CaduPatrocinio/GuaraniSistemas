unit uDmDados;

interface

uses
  System.SysUtils, System.Classes, IBX.IBDatabase, Data.DB, IBX.IBCustomDataSet,
  IBX.IBQuery, Datasnap.DBClient, Datasnap.Provider, extctrls;

type
  TDmDados = class(TDataModule)
    IBTransaction: TIBTransaction;
    IBDatabase: TIBDatabase;
    PGeral: TDataSetProvider;
    CDGeral: TClientDataSet;
    DSGeral: TDataSource;
    QGeral: TIBQuery;
    PMarcas: TDataSetProvider;
    CDMarcas: TClientDataSet;
    DsMarcas: TDataSource;
    QMarcas: TIBQuery;
    CDMarcasID_MARCA: TIntegerField;
    CDMarcasMARCA: TWideStringField;
    PProdutos: TDataSetProvider;
    CDProdutos: TClientDataSet;
    DsProdutos: TDataSource;
    QProdutos: TIBQuery;
    CDProdutosID_PRODUTO: TIntegerField;
    CDProdutosID_MARCA: TIntegerField;
    CDProdutosDESCRICAO: TWideStringField;
    CDProdutosVALOR: TBCDField;
    PClientes: TDataSetProvider;
    CDClientes: TClientDataSet;
    DsClientes: TDataSource;
    QClientes: TIBQuery;
    CDClientesID_CLIENTE: TIntegerField;
    CDClientesNOME_FANTASIA: TWideStringField;
    CDClientesRAZAO_SOCIAL: TWideStringField;
    CDClientesCNPJ: TWideStringField;
    CDClientesCEP: TWideStringField;
    CDClientesENDERECO: TWideStringField;
    CDClientesNUMERO: TWideStringField;
    CDClientesBAIRRO: TWideStringField;
    CDClientesCIDADE: TWideStringField;
    CDClientesUF: TWideStringField;
    CDClientesTELEFONE: TWideStringField;
    CDProdutosMarca: TStringField;
    PPedido: TDataSetProvider;
    CDPedido: TClientDataSet;
    DsPedido: TDataSource;
    QPedido: TIBQuery;
    CDPedidoID_PEDIDO: TIntegerField;
    CDPedidoID_CLIENTE: TIntegerField;
    CDPedidoDT_PEDIDO: TDateField;
    CDPedidoHORA_PEDIDO: TTimeField;
    CDPedidoSUB_TOTAL: TBCDField;
    CDPedidoDESCONTO: TBCDField;
    CDPedidoTOTAL: TBCDField;
    PItemPedido: TDataSetProvider;
    CDItemPedido: TClientDataSet;
    DsItemPedido: TDataSource;
    QItemPedido: TIBQuery;
    CDItemPedidoID_ITEM_PEDIDO: TIntegerField;
    CDItemPedidoID_PEDIDO: TIntegerField;
    CDItemPedidoID_PRODUTO: TIntegerField;
    CDItemPedidoQTDE: TIntegerField;
    DsPedidoItem: TDataSource;
    CDPedidoQItemPedido: TDataSetField;
    CDItemPedidoVALOR_UNITARIO: TBCDField;
    CDItemPedidoVALOR_TOTAL: TBCDField;
    CDPedidoNomeCli: TStringField;
    CDItemPedidoDescricao: TStringField;
    function PGeralDataRequest(Sender: TObject; Input: OleVariant): OleVariant;
    function PMarcasDataRequest(Sender: TObject; Input: OleVariant): OleVariant;
    procedure CDMarcasAfterInsert(DataSet: TDataSet);
    procedure CDMarcasReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    function PProdutosDataRequest(Sender: TObject;
      Input: OleVariant): OleVariant;
    procedure CDProdutosAfterInsert(DataSet: TDataSet);
    procedure CDProdutosReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    function PClientesDataRequest(Sender: TObject;
      Input: OleVariant): OleVariant;
    procedure CDClientesAfterInsert(DataSet: TDataSet);
    procedure CDProdutosID_MARCAChange(Sender: TField);
    function PPedidoDataRequest(Sender: TObject; Input: OleVariant): OleVariant;
    function PItemPedidoDataRequest(Sender: TObject;
      Input: OleVariant): OleVariant;
    procedure CDItemPedidoID_PRODUTOChange(Sender: TField);
    procedure CDItemPedidoCalcFields(DataSet: TDataSet);
    procedure CDItemPedidoQTDEChange(Sender: TField);
    procedure CDItemPedidoVALOR_TOTALChange(Sender: TField);
    procedure CDPedidoAfterInsert(DataSet: TDataSet);
    procedure CDPedidoID_CLIENTEChange(Sender: TField);
    procedure CDItemPedidoAfterInsert(DataSet: TDataSet);
    procedure CDPedidoBeforeDelete(DataSet: TDataSet);
    procedure CDPedidoCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  function GeneratorID(Generator: String): Integer;
  end;

var
  DmDados: TDmDados;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UFerramentas;

{$R *.dfm}

procedure TDmDados.CDClientesAfterInsert(DataSet: TDataSet);
begin
  CDClientesID_CLIENTE.AsInteger := GeneratorID('GEN_ID_CLIENTE');
end;

procedure TDmDados.CDItemPedidoAfterInsert(DataSet: TDataSet);
begin
  CDItemPedidoID_ITEM_PEDIDO.AsInteger := GeneratorID('GEN_ID_ITEM_PEDIDO');
  CDItemPedidoQTDE.AsInteger := 1;
end;

procedure TDmDados.CDItemPedidoCalcFields(DataSet: TDataSet);
begin
  if not CDItemPedidoID_PRODUTO.IsNull then
   begin
     Posicionar_Dados(CdProdutos,'PRODUTOS','ID_PRODUTO', CDItemPedidoID_PRODUTO.AsString);
     CDItemPedidoDescricao.AsString := CdProdutosDESCRICAO.AsString;
   end;
end;

procedure TDmDados.CDItemPedidoID_PRODUTOChange(Sender: TField);
begin
  Posicionar_Dados(DmDados.CDProdutos,'PRODUTOS','ID_PRODUTO', CDItemPedidoID_PRODUTO.AsString);
  CDItemPedidoDescricao.AsString     := DmDados.CDProdutosDESCRICAO.AsString;
  CDItemPedidoVALOR_UNITARIO.AsFloat := DmDados.CDProdutosVALOR.AsFloat;
  CDItemPedidoVALOR_TOTAL.AsFloat    := CDItemPedidoVALOR_UNITARIO.AsFloat * CDItemPedidoQTDE.AsFloat;
end;

procedure TDmDados.CDItemPedidoQTDEChange(Sender: TField);
begin
  CDItemPedidoVALOR_TOTAL.AsFloat := CDItemPedidoVALOR_UNITARIO.AsFloat * CDItemPedidoQTDE.AsFloat;
end;

procedure TDmDados.CDItemPedidoVALOR_TOTALChange(Sender: TField);
var bmk : TBookmark;
begin
  if ((CDItemPedidoID_PRODUTO.AsString = '') or (CDItemPedidoID_PRODUTO.IsNull)) then
      Exit;

  CDItemPedido.DisableControls;
  bmk := CDItemPedido.GetBookmark;
  CDItemPedido.First;
  CDPedidoTOTAL.AsFloat  := 0;

  while not (CDItemPedido.Eof) do
   begin
    if CDItemPedidoVALOR_TOTAL.AsFloat > 0 then
     begin
      CDPedidoTOTAL.AsFloat := CDPedidoTOTAL.AsFloat + CDItemPedidoVALOR_TOTAL.AsFloat;
     end;
      CDItemPedido.Next;
     end;

  CDItemPedido.GotoBookmark(bmk);
  CDItemPedido.FreeBookmark(bmk);
  CDItemPedido.EnableControls;
  CDItemPedido.Edit;
end;

procedure TDmDados.CDMarcasAfterInsert(DataSet: TDataSet);
begin
 CDMarcasID_MARCA.AsInteger := GeneratorID('GEN_ID_MARCA');
end;

procedure TDmDados.CDMarcasReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  if pos('MARCAS_MARCA_JA_EXISTE',e.Message) > 0 then
   begin
     Aviso('Marca já cadastrada!');
     Exit;
   end;
end;

procedure TDmDados.CDPedidoAfterInsert(DataSet: TDataSet);
begin
  CDPedidoID_PEDIDO.AsInteger    := GeneratorID('GEN_ID_PEDIDO');
  CDPedidoDT_PEDIDO.AsDateTime   := Date;
  CDPedidoHORA_PEDIDO.AsDateTime := Time;
  CDPedidoSUB_TOTAL.AsFloat := 0;
  CDPedidoDESCONTO.AsFloat  := 0;
  CDPedidoTOTAL.AsFloat     := 0;
end;

procedure TDmDados.CDPedidoBeforeDelete(DataSet: TDataSet);
begin
  CDPedido.First;
  while not CDItemPedido.Eof  do
        CDItemPedido.Delete;
end;

procedure TDmDados.CDPedidoCalcFields(DataSet: TDataSet);
begin
  if CDPedidoID_CLIENTE.AsString <> '' then
   BEGIN
   Posicionar_Dados(CDClientes,'CLIENTES','ID_CLIENTE', CDPedidoID_CLIENTE.AsString);
   CDPedidoNomeCli.AsString  := CDClientesNOME_FANTASIA.AsString;
   END;
end;

procedure TDmDados.CDPedidoID_CLIENTEChange(Sender: TField);
var PnProduto: TPanel;
begin
  PnProduto := TPanel.Create(Self);
  if CDPedidoNomeCli.AsString = '' then
    begin
      Retornar_Dados('CLIENTES','CLIENTES',CDPedidoID_CLIENTE.AsString,'NOME_FANTASIA', PnProduto, PnProduto);
      CDPedidoNomeCli.AsString := PnProduto.Caption;
     end;

end;

procedure TDmDados.CDProdutosAfterInsert(DataSet: TDataSet);
begin
 CDProdutosID_PRODUTO.AsInteger := GeneratorID('GEN_ID_PRODUTO');
end;

procedure TDmDados.CDProdutosID_MARCAChange(Sender: TField);
begin
  Posicionar_Dados(DmDados.CDMarcas,'MARCAS','ID_MARCA', CDProdutosID_MARCA.AsString);
  CDProdutosMarca.AsString := DmDados.CDMarcasMARCA.AsString;
end;

procedure TDmDados.CDProdutosReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  if pos('PRODUTOS_PRODUTO_JA_EXISTE',e.Message) > 0 then
   begin
     Aviso('Produto já cadastrado!');
     Exit;
   end;
end;

function TDmDados.GeneratorID(Generator: String): Integer;
var QGenerator: TIBQuery;
begin
  QGenerator := TIBQuery.Create(Self);
  QGenerator.Database := IBDatabase;
  QGenerator.SQL.Add('SELECT GEN_ID ('+Generator+', 1) FROM RDB$DATABASE');
  QGenerator.Open;
  Result := QGenerator.Fields[0].AsInteger;
end;

function TDmDados.PClientesDataRequest(Sender: TObject;
  Input: OleVariant): OleVariant;
begin
  QClientes.SQL.Text := Input;
end;

function TDmDados.PGeralDataRequest(Sender: TObject;
  Input: OleVariant): OleVariant;
begin
  QGeral.SQL.Text := Input;
end;

function TDmDados.PItemPedidoDataRequest(Sender: TObject;
  Input: OleVariant): OleVariant;
begin
  QItemPedido.SQL.Text := Input;
end;

function TDmDados.PMarcasDataRequest(Sender: TObject;
  Input: OleVariant): OleVariant;
begin
  QMarcas.SQL.Text := Input;
end;

function TDmDados.PPedidoDataRequest(Sender: TObject;
  Input: OleVariant): OleVariant;
begin
  QPedido.SQL.Text := Input;
end;

function TDmDados.PProdutosDataRequest(Sender: TObject;
  Input: OleVariant): OleVariant;
begin
  QProdutos.SQL.Text := Input;
end;

end.
