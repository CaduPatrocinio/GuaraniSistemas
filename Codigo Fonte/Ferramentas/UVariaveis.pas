unit UVariaveis;

interface

Uses Db, DBClient;

type

  TSet_TabelaMaster = (stResetar, stManter_Dados);

  TReg_Produto = record
    ID_Produto: String;
    Descricao: String;
    VL_Unitario: Real;
  end;

  TEmpresa = record
    Nome: String;
    Cidade_id: Integer;
    UF: String;
  end;

  TPesquisa = record
    Tab_Cliente: TClientDataSet;
    Tab_Banco: String;
    Titulo: String;
    Campos_Pesquisa: Array [0 .. 3] of String;
    Condicao: String;
  end;

  TSQLs = record
    Clientes,
    Marcas,
    Pedidos,
    Produtos : String;
  end;

  TPesquisas = record
    Clientes,
    Marcas,
    Pedidos,
    Produtos : TPesquisa;
  end;

var
  SQLs: TSQLs;
  Pesquisa_Master: TPesquisa;
  Ajustar_Pesquisa: TPesquisas;
  Empresa: TEmpresa;

implementation

initialization

with SQLs do
begin
  Clientes := 'SELECT * FROM CLIENTES WHERE ID_CLIENTE IS NULL';
  Marcas   := 'SELECT * FROM MARCAS   WHERE ID_MARCA   IS NULL';
  Pedidos  := 'SELECT * FROM PEDIDO   WHERE ID_PEDIDO  IS NULL';
  Produtos := 'SELECT * FROM PRODUTOS WHERE ID_PRODUTO IS NULL' ;
end;

end.
