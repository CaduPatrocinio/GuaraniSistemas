unit UFerramentas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, ComCtrls, ToolWin, Db, DBClient, stdctrls, extctrls,
  dbctrls, MConnect, IniFiles, UVariaveis, StrUtils, Variants;

function State_Insert(Tabela: TDataSet): Boolean;
function Mensagem(Mens, Titulo: String; Tipo: byte): byte;
function Confirma(Mens: String): Boolean;
function ConfirmaOuCancela(Mens: String): Integer;
procedure Aviso(Mens: String);
procedure Erro(Mens: String);
procedure Informacao(Mens: String);
procedure Ativar_Tabela(Tabela: TDataSet; SQL: String;
  Resetar_Tabela: TSet_TabelaMaster);
function Verfica_String(SQL: String; Resetar_Tabela: TSet_TabelaMaster): string;
procedure Desativar_Tabela(Tabela: TDataSet);
procedure Retornar_Dados(Tab_Banco, Chave, Valor_Chave, RetornarCampos: String;
  var Comp_Retorno_1, Comp_Retorno_2: TPanel);
function Tabela_vazia(Tab_Banco, Mensagem: String;
  ShowMesagen: Boolean = True): Boolean;
procedure Verifica_CNPJ(CNPJ: String; var Objeto: TDBEdit;
  ShowMensagem: Boolean = False);
procedure Verifica_CPF(CPF: String; var Objeto: TDBEdit;
  ShowMensagem: Boolean = False);
procedure Conectar_Servidor(DCOM: TDCOMConnection);
procedure Posicionar_Dados(TabCliente: TClientDataSet;
  Tab_Banco, Chave, Valor_Chave: String);
procedure Executar_SQL(SQL: String);
function Novo_Codigo(Tabela: String): Integer;
procedure Devolver_Codigo(Tabela, Chave: String; Codigo: Integer);
function Agrupar_Itens(DataSet: TDataSet): Boolean;
procedure Gravar_Itens(DataSet: TDataSet; Produto: TReg_Produto;
  Total_Qtd: Real);
function Definir_Pesquisa(Tab_Cliente: TClientDataSet; Tab_Banco: String = '';
  Titulo: String = 'Pesquisa'; Index_1: String = ''; Index_2: String = '';
  Index_3: String = ''; Index_4: String = ''; Condicao: String = ''): TPesquisa;

function Extenso(Valor: Extended): String;
Function fCheckEmail(Email: String): Boolean;
function ApenasNumeros(Valor: string): string;
function validacaoInicial(Valor: string): Boolean;
function AbreviaNome(Nome: String): String;
function Tira_Acento(str: String): String;
function Pot(base, expoente: Real): Real; // Potenciação
function Calc_Juros(Valor, i: Real; pz: Integer): Real;

/// //Datas///////
function Data_Fim_Semana(dEntrega, dData: TDateTime): Boolean;
// Retorna a porcentagem de um valor
function Gerapercentual(Valor: Real; Percent: Real): Real;
// Zeros Esquerda
{ Remove os Espaços em branco à direita a esquerdada string }
function LTrim(Texto: String): String;
{ Converte a primeira letra do texto especificado para maiuscula e as restantes para minuscula }
function PMaiuscula(Texto: String): String;
function DataValida(StrD: string): Boolean;
// Esta função retorna o texto que está entre caracteres.
function RetornaTexto(Texto: String; Caracter: Char): String;
// Diferança entre duas datas
function DifDias(DataVenc: TDateTime; DataAtual: TDateTime): String;
function DataExtenso(Data: TDateTime): String;
function Maiuscula(Texto: String): String;

// Função que valida campos obriaórios  =  Colocando Tag = 1
// Pode ser adaptada para qualquer componente
function ValidaCamposTag(Formulario: Tform): Boolean;
// Funções Para Calcular Idade
Function CalculaIdade(DataIni, DataFim: TDateTime): string;
Function CalculaIdade2(DataNascimento: String): Integer;

//////////////
///
function RetirarCaracteres(Texto, CaracteresRetirar: string): string;

implementation

uses uDmDados;


function State_Insert(Tabela: TDataSet): Boolean;
begin
  Result := (Tabela.State in [dsEdit, dsInsert]);
end;

function Mensagem(Mens, Titulo: String; Tipo: byte): byte;
var
  Botoes: Integer;
begin
  Botoes := mb_Ok;
  case Tipo of
    0:
      Botoes := Mb_YesNo + mb_IconQuestion;
    1:
      Botoes := mb_Ok + mb_IconExclamation;
    2:
      Botoes := mb_Ok + mb_IconStop;
    3:
      Botoes := mb_Ok + mb_IconInformation;
    4:
      Botoes := Mb_YesNoCancel + mb_IconQuestion;
  end;
  Result := Application.MessageBox(PChar(Mens), PChar(Titulo), Botoes);
end;

function Confirma(Mens: String): Boolean;
begin
  Result := Mensagem(Mens, 'Consulta', 0) = IDYES;
end;

function ConfirmaOuCancela(Mens: String): Integer;
begin
  Result := Mensagem(Mens, 'Consulta', 4);
end;

procedure Aviso(Mens: String);
begin
  Mensagem(Mens, 'Aviso', 1);
end;

procedure Erro(Mens: String);
begin
  Mensagem(Mens, 'Erro', 2);
end;

procedure Informacao(Mens: String);
begin
  Mensagem(Mens, 'Informação', 3);
end;

procedure Ativar_Tabela(Tabela: TDataSet; SQL: String;
  Resetar_Tabela: TSet_TabelaMaster);
begin
  if (Tabela <> nil) and (not Tabela.Active) then
  begin
    if not(SQL = '') then
      TClientDataSet(Tabela).DataRequest(Verfica_String(SQL, Resetar_Tabela));
    Tabela.Open;
  end;
end;

function Verfica_String(SQL: String; Resetar_Tabela: TSet_TabelaMaster): String;
begin
  SQL := AnsiUpperCase(SQL);
  case Resetar_Tabela of
    stManter_Dados:
      SQL := Copy(SQL, 1, (Pos('WHERE', SQL)) - 1);
  end;
  Result := SQL;
end;

procedure Desativar_Tabela(Tabela: TDataSet);
begin
  if (Tabela <> nil) and (Tabela.Active) then
    Tabela.Close;
end;

procedure Retornar_Dados(Tab_Banco, Chave, Valor_Chave, RetornarCampos: String;
  var Comp_Retorno_1, Comp_Retorno_2: TPanel);
var
  SQL, CampoRetorno1, CampoRetorno2: String;
  i: byte;
begin

  CampoRetorno1 := RetornarCampos;
  CampoRetorno2 := RetornarCampos;

  i := Pos(';', RetornarCampos);

  if (i > 0) then
  begin
    CampoRetorno1 := Copy(RetornarCampos, 1, i - 1);
    CampoRetorno2 := Copy(RetornarCampos, i + 1, length(RetornarCampos));
  end;

  SQL := 'SELECT ';

  if CampoRetorno1 <> '' then
    SQL := SQL + CampoRetorno1;

  if CampoRetorno2 <> '' then
    if CampoRetorno1 <> '' then
      SQL := SQL + ',' + CampoRetorno2
    else
      SQL := SQL + CampoRetorno2;

  if Valor_Chave <> '' then
    SQL := SQL + (' FROM ' + Tab_Banco + ' WHERE ' + Chave + '= ' +
      QuotedStr(Valor_Chave))
  else
    SQL := SQL + (' FROM ' + Tab_Banco + ' WHERE ' + Chave + ' IS NULL ');

  with DmDados.CDGeral do
  begin
    Close;

    DataRequest(SQL);
    Open;

    if (Comp_Retorno_1 <> nil) and (CampoRetorno1 <> '') then
      Comp_Retorno_1.Caption := ' ' + FieldByName(CampoRetorno1).AsString;

    if (Comp_Retorno_2 <> nil) and (CampoRetorno2 <> '') then
      Comp_Retorno_2.Caption := ' ' + FieldByName(CampoRetorno2).AsString;

    Close;
  end;

end;

function Tabela_vazia(Tab_Banco, Mensagem: String;
  ShowMesagen: Boolean = True): Boolean;
begin
  with DmDados.CDGeral do
  begin
    Close;
    PacketRecords := 1;
    DataRequest('SELECT * FROM ' + Tab_Banco);
    Open;
    Result := IsEmpty;
    Close;
    PacketRecords := -1;

    if (Result and ShowMesagen) then
      Aviso(Mensagem);
  end;
end;

procedure Verifica_CNPJ(CNPJ: String; var Objeto: TDBEdit;
  ShowMensagem: Boolean = False);
var
  i: byte;
  num1, num4, aux, Fat, Rest, Digito1, Digito2: Integer;
  Verificador: String;
begin

  if CNPJ = '' then
    Exit;
  num1 := 0;
  num4 := 0;
  aux := 1;

  for i := 1 to length(CNPJ) - 2 do
  begin
    if not(CNPJ[i] in ['/', '-', '.']) then
    begin
      if aux < 5 then
        Fat := 6 - aux
      else
        Fat := 14 - aux;
      num1 := num1 + StrToInt(CNPJ[i]) * Fat;
      if aux < 6 then
        Fat := 7
      else
        Fat := 15 - aux;
      num4 := num4 + StrToInt(CNPJ[i]) * Fat;
      Inc(aux);
    end;
  end;

  Rest := (num1 mod 11);
  if Rest < 2 then
    Digito1 := 0
  else
    Digito1 := 11 - Rest;

  num4 := num4 + 2 * Digito1;
  Rest := (num4 mod 11);

  if Rest < 2 then
    Digito2 := 0
  else
    Digito2 := 11 - Rest;

  Verificador := IntToStr(Digito1) + IntToStr(Digito2);

  if Verificador = CNPJ[13] + CNPJ[14] then
    Objeto.Font.Color := clBlack
  else
  begin
    if ShowMensagem then
      Erro('CNPJ inválido!');
    Objeto.Font.Color := clRed;
  end;
end;

procedure Verifica_CPF(CPF: String; var Objeto: TDBEdit;
  ShowMensagem: Boolean = False);
var
  num1, num4, aux, i, Rest, Digito1, Digito2: Integer;
  Verificador: String;
begin

  { if CPF = ''
    then Exit; }
  if not validacaoInicial(CPF) then
  begin
    Erro('CPF inválido!');
    Objeto.Font.Color := clRed;
    Objeto.SetFocus;
    Exit;
  end;
  { Aqui vem o restante do seu código de validação }
  num1 := 0;
  num4 := 0;
  aux := 1;
  for i := 1 to length(CPF) - 2 do
  begin
    if not(CPF[i] in ['/', '-', '.']) then
    begin
      num1 := num1 + (11 - aux) * StrToInt(CPF[i]);
      num4 := num4 + (12 - aux) * StrToInt(CPF[i]);
      Inc(aux);
    end;
  end;

  Rest := (num1 mod 11);
  if Rest < 2 then
    Digito1 := 0
  else
    Digito1 := 11 - Rest;
  num4 := num4 + 2 * Digito1;

  Rest := (num4 mod 11);
  if Rest < 2 then
    Digito2 := 0
  else
    Digito2 := 11 - Rest;

  Verificador := IntToStr(Digito1) + IntToStr(Digito2);

  if Verificador = CPF[10] + CPF[11] then
    Objeto.Font.Color := clBlack
  else
  begin
    if ShowMensagem then
      Erro('CPF inválido!');
    Objeto.Font.Color := clRed;
  end;
end;

procedure Conectar_Servidor(DCOM: TDCOMConnection);
var
  f3Camadas: TIniFile;
  ComputerName: String;
begin

  f3Camadas := TIniFile.Create('C:\PowerShop\PowerShop.ini');
  ComputerName := f3Camadas.ReadString('Servidor', 'ComputerName', '');
  DCOM.ComputerName := ComputerName;
  if ComputerName = '' then
    f3Camadas.WriteString('Servidor', 'ComputerName', ComputerName);
  f3Camadas.Free;

end;

procedure Posicionar_Dados(TabCliente: TClientDataSet;
  Tab_Banco, Chave, Valor_Chave: String);
var
  SQL: String;
begin
  SQL := ('SELECT * FROM ' + Tab_Banco + ' WHERE ' + Chave + ' =' +
    QuotedStr(Valor_Chave));

  try
    with TabCliente do
    begin
      Close;
      DataRequest(SQL);
      Open;
    end;
  except
  end;

end;

procedure Executar_SQL(SQL: String);
begin
  // DmCadastro.DCOMConnection.AppServer.Executar_SQL(SQL);
end;

function Novo_Codigo(Tabela: String): Integer;
begin
  // Result := DmCadastro.DCOMConnection.AppServer.Novo_Codigo(Tabela);
end;

procedure Devolver_Codigo(Tabela, Chave: String; Codigo: Integer);
begin
  // DmCadastro.DCOMConnection.AppServer.Devolver_Codigo(Tabela, Chave, Codigo);
end;

function Agrupar_Itens(DataSet: TDataSet): Boolean;
var
  i, j: Integer;
  Total_Qtd: Real;
  Total_Itens: Integer;
  Produtos: array [1 .. 500] of TReg_Produto;
  CalcFields: TDataSetNotifyEvent;
begin
  with DataSet do
  begin
    DisableControls;
    First;
    Result := False;
    i := 1;

    CalcFields := DataSet.OnCalcFields;
    OnCalcFields := nil;

    while not Eof do
    begin
      if FieldByName('ID_PRODUTO').AsString = '' then
        Delete
      else
      begin
        Produtos[i].ID_Produto  := FieldByName('ID_PRODUTO').AsString;
        Produtos[i].Descricao   := FieldByName('DESCRICAO').AsString;
        Produtos[i].VL_Unitario := FieldByName('VALOR_UNITARIO').AsFloat;
        Inc(i);
        if i > 500 then
        begin
          Aviso('O limite do vetor de itens é de 500 lançamentos');
          EnableControls;
          Exit;
        end;
        Next;
      end;
    end;
    for j := 1 to i - 1 do
    begin
      if not(IsEmpty) then
        First;
      Total_Qtd := 0;
      Total_Itens := 0;
      while not Eof do
      begin
        if (FieldByName('ID_Produto').AsString = Produtos[j].ID_Produto) then
        begin
          Total_Qtd := Total_Qtd + FieldByName('QTDE').AsFloat;
          Inc(Total_Itens);
        end;
        Next;
      end;
      if Total_Itens > 1 then
        Gravar_Itens(DataSet, Produtos[j], Total_Qtd);
    end;
    First;
    Result := True;
    EnableControls;
    DataSet.OnCalcFields := CalcFields;
  end;
end;

procedure Gravar_Itens(DataSet: TDataSet; Produto: TReg_Produto;
  Total_Qtd: Real);
begin
  with DataSet do
  begin
    First;
    while not Eof do
      if (FieldByName('ID_Produto').AsString = Produto.ID_Produto) then
      begin
        Delete;
        if not(IsEmpty) then
          First;
      end
      else
        Next;
    Append;

    FieldByName('ID_Produto').AsString := Produto.ID_Produto;
    Edit;
    FieldByName('DESCRICAO').AsString := Produto.Descricao;
    Edit;
    FieldByName('QTDE').AsFloat := Total_Qtd;
    Edit;
    FieldByName('VALOR_UNITARIO').AsFloat := Produto.VL_Unitario;
  end;
end;

function Definir_Pesquisa(Tab_Cliente: TClientDataSet; Tab_Banco: String = '';
  Titulo: String = 'Pesquisa'; Index_1: String = ''; Index_2: String = '';
  Index_3: String = ''; Index_4: String = ''; Condicao: String = ''): TPesquisa;
begin

  Result.Tab_Cliente := Tab_Cliente;
  Result.Tab_Banco := Tab_Banco;
  Result.Titulo := Titulo;
  Result.Campos_Pesquisa[0] := Index_1;
  Result.Campos_Pesquisa[1] := Index_2;
  Result.Campos_Pesquisa[2] := Index_3;
  Result.Campos_Pesquisa[3] := Index_4;
  Result.Condicao := Condicao;
end;

{ Valor por extenso de moedas
  ************************************************************************ }
function Extenso(Valor: Extended): String;
var
  Centavos, Centena, Milhar, Milhao, Bilhao, Texto: string;
const
  Unidades: array [1 .. 9] of string = ('um', 'dois', 'três', 'quatro', 'cinco',
    'seis', 'sete', 'oito', 'nove');
  Dez: array [1 .. 9] of string = ('onze', 'doze', 'treze', 'quatorze',
    'quinze', 'dezesseis', 'dezessete', 'dezoito', 'dezenove');
  Dezenas: array [1 .. 9] of string = ('dez', 'vinte', 'trinta', 'quarenta',
    'cinquenta', 'sessenta', 'setenta', 'oitenta', 'noventa');
  Centenas: array [1 .. 9] of string = ('cento', 'duzentos', 'trezentos',
    'quatrocentos', 'quinhentos', 'seiscentos', 'setecentos', 'oitocentos',
    'novecentos');

  function ifs(Expressao: Boolean; CasoVerdadeiro, CasoFalso: String): String;
  begin
    if Expressao then
      Result := CasoVerdadeiro
    else
      Result := CasoFalso;
  end;

  function MiniExtenso(Valor: String): string;
  var
    Unidade, Dezena, Centena: String;
  begin

    Unidade := '';
    Dezena := '';
    Centena := '';

    if (Valor[2] = '1') and (Valor[3] <> '0') then
    begin
      Unidade := Dez[StrToInt(Valor[3])];
      Dezena := '';
    end
    else
    begin
      if Valor[2] <> '0' then
        Dezena := Dezenas[StrToInt(Valor[2])];
      if Valor[3] <> '0' then
        Unidade := Unidades[StrToInt(Valor[3])];
    end;

    if (Valor[1] = '1') and (Unidade = '') and (Dezena = '') then
      Centena := 'cem'
    else if Valor[1] <> '0' then
      Centena := Centenas[StrToInt(Valor[1])]
    else
      Centena := '';

    Result := Centena + ifs((Centena <> '') and
      ((Dezena <> '') or (Unidade <> '')), ' e ', '') + Dezena +
      ifs((Dezena <> '') and (Unidade <> ''), ' e ', '') + Unidade;
  end;

begin

  if Valor = 0 then
  begin
    Result := '';
    Exit;
  end;

  Texto := FormatFloat('000000000000.00', Valor);
  Centavos := MiniExtenso('0' + Copy(Texto, 14, 2));
  Centena := MiniExtenso(Copy(Texto, 10, 3));
  Milhar := MiniExtenso(Copy(Texto, 7, 3));

  if Milhar <> '' then
    Milhar := Milhar + ' Mil';
  Milhao := MiniExtenso(Copy(Texto, 4, 3));

  if Milhao <> '' then
    Milhao := Milhao + ifs(Copy(Texto, 4, 3) = '001', ' Milhão', ' milhões');
  Bilhao := MiniExtenso(Copy(Texto, 1, 3));

  if Bilhao <> '' then
    Bilhao := Bilhao + ifs(Copy(Texto, 1, 3) = '001', ' Bilhão', ' bilhões');

  if (Bilhao <> '') and (Milhao + Milhar + Centena = '') then
    Result := Bilhao + ' de Reais'
  else if (Milhao <> '') and (Milhar + Centena = '') then
    Result := Milhao + ' de Reais'
  else
    Result := Bilhao + ifs((Bilhao <> '') and (Milhao + Milhar + Centena <> ''),
      ifs((Pos(' e ', Bilhao) > 0) or (Pos(' e ', Milhao + Milhar + Centena) >
      0), ', ', ' e '), '') + Milhao +
      ifs((Milhao <> '') and (Milhar + Centena <> ''),
      ifs((Pos(' e ', Milhao) > 0) or (Pos(' e ', Milhar + Centena) > 0), ', ',
      ' e '), '') + Milhar + ifs((Milhar <> '') and (Centena <> ''),
      ifs(Pos(' e ', Centena) > 0, ', ', ' e '), '') + Centena +
      ifs(Int(Valor) = 1, ' Real', ifs(Int(Valor) > 1, ' Reais', ''));
  if Centavos <> '' then
    Result := Result + ifs(Centena <> '', ' e ', '') + Centavos +
      ifs(Copy(Texto, 14, 2) = '01', ' centavo', ' centavos');
end;

/// ////////Verifica Email/////////////
Function fCheckEmail(Email: String): Boolean;
var { sintaxe: nome@provedor.com.br }
  s: String;
  EPos: Integer;
begin
  EPos := Pos('@', Email);
  if EPos > 1 then
  begin
    s := Copy(Email, EPos + 1, length(Email));
    if (Pos('.', s) > 1) and (Pos('.', s) < length(s)) then
      Result := True
    else
      Result := False;
  end
  else
    Result := False;
End;

/// /////////////Apenas Numeros//////////
function ApenasNumeros(Valor: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to (length(Valor)) do
    if (Valor[i] in ['0' .. '9']) then
      Result := Trim(Result + Valor[i]);
end;

/// ////////////Varlor Inicail//////////////
function validacaoInicial(Valor: string): Boolean;
begin
  Result := AnsiReplaceStr(ApenasNumeros(Valor), Valor[1], '') <> '';
end;

function AbreviaNome(Nome: String): String;
var
  Nomes: array [1 .. 20] of string;
  i, TotalNomes: Integer;
begin
  Nome := Trim(Nome);
  Result := Nome;
  { Insere um espaço para garantir que todas as letras sejam testadas }
  Nome := Nome + #32;
  { Pega a posição do primeiro espaço }
  i := Pos(#32, Nome);
  if i > 0 then
  begin
    TotalNomes := 0;
    { Separa todos os nomes }
    while i > 0 do
    begin
      Inc(TotalNomes);
      Nomes[TotalNomes] := Copy(Nome, 1, i - 1);
      Delete(Nome, 1, i);
      i := Pos(#32, Nome);
    end;
    if TotalNomes > 1 then
    begin
      { Abreviar a partir do segundo nome, exceto o último. }
      for i := 1 to TotalNomes - 0 do // todos os nomes
      begin
        { Contém mais de 3 letras? (ignorar de, da, das, do, dos, etc.) }
        if length(Nomes[i]) > 3 then
          { Pega apenas a primeira letra do nome e coloca um ponto após. }
          Nomes[i] := Nomes[i, 1] + Nomes[i, 2] + Nomes[i, 3];
        // Nomes[i] := ;
        // Nomes[i] := Nomes[i,3]{[1]} + '.';
      end;
      Result := '';
      for i := 1 to TotalNomes do
        Result := Result + Trim(Nomes[i]) + #32;
      Result := Trim(Result);
    end;
  end;
end;

function Tira_Acento(str: String): String;
var
  i: Integer;
begin
  for i := 1 to length(str) do
    case str[i] of
      'á':
        str[i] := 'a';
      'é':
        str[i] := 'e';
      'í':
        str[i] := 'i';
      'ó':
        str[i] := 'o';
      'ú':
        str[i] := 'u';
      'à':
        str[i] := 'a';
      'è':
        str[i] := 'e';
      'ì':
        str[i] := 'i';
      'ò':
        str[i] := 'o';
      'ù':
        str[i] := 'u';
      'â':
        str[i] := 'a';
      'ê':
        str[i] := 'e';
      'î':
        str[i] := 'i';
      'ô':
        str[i] := 'o';
      'û':
        str[i] := 'u';
      'ä':
        str[i] := 'a';
      'ë':
        str[i] := 'e';
      'ï':
        str[i] := 'i';
      'ö':
        str[i] := 'o';
      'ü':
        str[i] := 'u';
      'ã':
        str[i] := 'a';
      'õ':
        str[i] := 'o';
      'ñ':
        str[i] := 'n';
      'ç':
        str[i] := 'c';
      'Á':
        str[i] := 'A';
      'É':
        str[i] := 'E';
      'Í':
        str[i] := 'I';
      'Ó':
        str[i] := 'O';
      'Ú':
        str[i] := 'U';
      'À':
        str[i] := 'A';
      'È':
        str[i] := 'E';
      'Ì':
        str[i] := 'I';
      'Ò':
        str[i] := 'O';
      'Ù':
        str[i] := 'U';
      'Â':
        str[i] := 'A';
      'Ê':
        str[i] := 'E';
      'Î':
        str[i] := 'I';
      'Ô':
        str[i] := 'O';
      'Û':
        str[i] := 'U';
      'Ä':
        str[i] := 'A';
      'Ë':
        str[i] := 'E';
      'Ï':
        str[i] := 'I';
      'Ö':
        str[i] := 'O';
      'Ü':
        str[i] := 'U';
      'Ã':
        str[i] := 'A';
      'Õ':
        str[i] := 'O';
      'Ñ':
        str[i] := 'N';
      'Ç':
        str[i] := 'C';
    end;
  Result := str;
end;

/// /Calcula Juros Composto
Function Pot(base, expoente: Real): Real; // Potenciação
begin
  { utiliza a função de exponencial e de logaritmo }
  Result := Exp((expoente * Ln(base)));
end;

Function Calc_Juros(Valor, i: Real; pz: Integer): Real;
begin
  Result := Valor * (Pot((1 + i), (pz / 30))); // Resultado 1.050,00
end;

{ Verifica se uma data informada cai em um final de semana }
function Data_Fim_Semana(dEntrega, dData: TDateTime): Boolean;
begin
  if DayOfWeek(dData) = 1 then
  begin
    Result := True;
    Aviso('Data de entrega: "' + FormatDateTime('DD/MM/YYY', dData) +
      '" é um domingo!');
  end
  else if DayOfWeek(dData) = 7 then
  begin
    Result := True;
    Aviso('Data de entrega: "' + FormatDateTime('DD/MM/YYY', dData) +
      '" é um sabado!');
  end
  else
    Result := False;
  { if DayOfWeek(dData) in [1,7] then
    begin
    result := true
    else
    result := false; }
end;

function Gerapercentual(Valor: Real; Percent: Real): Real;
// Retorna a porcentagem de um valor
begin
  Percent := Percent / 100;
  try
    Valor := Valor * Percent;
  finally
    Result := Valor;
  end;
end;

function LTrim(Texto: String): String;
{ Remove os Espaços em branco à direita a e esquerdada string }
var
  i: Integer;
begin
  i := 0;
  while True do
  begin
    Inc(i);
    if i > length(Texto) then
      break;
    if Texto[i] <> #32 then
      break;
  end;

  Result := Copy(Texto, i, length(Texto));
  // Esquerda
  i := length(Result) + 1;
  while True do
  begin
    Dec(i);
    if i <= 0 then
      break;
    if Texto[i] <> #32 then
      break;
  end;
  Result := Copy(Result, 1, i);
end;

function PMaiuscula(Texto: String): String;
{ Converte a primeira letra do texto especificado para
  maiuscula e as restantes para minuscula }
var
  OldStart: Integer;
begin
  if Texto <> '' then
  begin
    Texto := UpperCase(Copy(Texto, 1, 1)) +
      LowerCase(Copy(Texto, 2, length(Texto)));
    Result := Texto;
  end;
end;

function DataValida(StrD: string): Boolean;
{ Testa se uma data é valida }
begin
  Result := True;
  try
    StrToDate(StrD);
  except
    on EConvertError do
      Result := False;
  end;
end;

Function RetornaTexto(Texto: String; Caracter: Char): String;
var
  i, Posicao1, Posicao2: Integer;
  TextoInvertido: String;
begin
  Result := '';
  for i := length(Texto) downto 1 do
  begin
    TextoInvertido := TextoInvertido + Texto[i]
  end;
  Posicao1 := Pos(Caracter, Texto) + 1;
  Posicao2 := Pos(Caracter, TextoInvertido) - 1;
  Result := Copy(Texto, Posicao1, length(Texto) - (Posicao1 + Posicao2));
end;

/// Diferenaça entre duas datas
function DifDias(DataVenc: TDateTime; DataAtual: TDateTime): String;
var
  Data: TDateTime;
  dia, mes, ano: Word;
begin
  if DataAtual < DataVenc then
  begin
    Result := 'A data data atual não pode ser menor que a data inicial';
  end
  else
  begin
    Data := DataAtual - DataVenc;
    DecodeDate(Data, ano, mes, dia);
    Result := FloatToStr(Data) + ' Dias';
  end;
end;

function DataExtenso(Data: TDateTime): String;
{ Retorna uma data por extenso }
var
  NoDia: Integer;
  DiaDaSemana: array [1 .. 7] of String;
  Meses: array [1 .. 12] of String;
  dia, mes, ano: Word;
begin
  { Dias da Semana }
  DiaDaSemana[1] := 'Domingo';
  DiaDaSemana[2] := 'Segunda-feira';
  DiaDaSemana[3] := 'Terçafeira';
  DiaDaSemana[4] := 'Quarta-feira';
  DiaDaSemana[5] := 'Quinta-feira';
  DiaDaSemana[6] := 'Sexta-feira';
  DiaDaSemana[7] := 'Sábado';
  { Meses do ano }
  Meses[1] := 'Janeiro';
  Meses[2] := 'Fevereiro';
  Meses[3] := 'Março';
  Meses[4] := 'Abril';
  Meses[5] := 'Maio';
  Meses[6] := 'Junho';
  Meses[7] := 'Julho';
  Meses[8] := 'Agosto';
  Meses[9] := 'Setembro';
  Meses[10] := 'Outubro';
  Meses[11] := 'Novembro';
  Meses[12] := 'Dezembro';
  DecodeDate(Data, ano, mes, dia);
  NoDia := DayOfWeek(Data);
  Result := DiaDaSemana[NoDia] + ', ' + IntToStr(dia) + ' de ' + Meses[mes] +
    ' de ' + IntToStr(ano);
end;

function Maiuscula(Texto: String): String;
{ Converte a primeira letra do texto especificado para
  maiuscula e as restantes para minuscula }
var
  OldStart: Integer;
begin
  if Texto <> '' then
  begin
    Texto := UpperCase(Copy(Texto, 1, 1)) +
    (* LowerCase *) (Copy(Texto, 2, length(Texto)));
    Result := Texto;
  end;
end;

function ValidaCamposTag(Formulario: Tform): Boolean;
var i: Integer;
begin
  for i := 0 to Formulario.ComponentCount - 1 do
  begin
    if Formulario.Components[i].ClassType = TDBEdit then
      if (Trim(TDBEdit(Formulario.Components[i]).Text) = '') And (TDBEdit(Formulario.Components[i]).Tag = 1) then
      begin
        Result := True;
        TEdit(Formulario.Components[i]).TextHint := 'Campo Obrigatório';
        Informacao('Preencha o campo ' + TDBEdit(Formulario.Components[i]).Field.DisplayLabel);
        TDBEdit(Formulario.Components[I]).SetFocus;
        Exit;
      end;

    if Formulario.Components[i].ClassType = TDBComboBox then
      if (Trim(TDBComboBox(Formulario.Components[i]).Text) = '') And (TDBComboBox(Formulario.Components[i]).Tag = 1) then
      begin
        Result := True;
        TComboBox(Formulario.Components[i]).TextHint := 'Campo Obrigatório';
        Informacao('Preencha o campo ' + TDBComboBox(Formulario.Components[i]).Field.DisplayLabel);
        TEdit(Formulario.Components[I]).SetFocus;
        Exit;
      end;

    if Formulario.Components[i].ClassType = TDBLookupComboBox then
      if (Trim(TDBLookupComboBox(Formulario.Components[i]).Text) = '') And (TDBLookupComboBox(Formulario.Components[i]).Tag = 1) then
      begin
        Result := True;
       // TDBLookupComboBox(Formulario.Components[i]).TextHint := 'Campo Obrigatório';
        Informacao('Preencha o campo ' + TDBLookupComboBox(Formulario.Components[i]).Field.DisplayLabel);
        TEdit(Formulario.Components[I]).SetFocus;
        Exit;
      end;
  end;
end;

Function CalculaIdade(DataIni, DataFim: TDateTime): string;
var
  Idade: String;
  Resto: Integer;
  iDia, iMes, iAno, fDia, fMes, fAno: Word;
  nDia, nMes, nAno, DiaBissexto: Double;
begin
  DecodeDate(DataIni, iAno, iMes, iDia);
  DecodeDate(DataFim, fAno, fMes, fDia);
  nAno := fAno - iAno;
  if nAno > 0 then
    if fMes < iMes then
      nAno := nAno - 1
    else if (fMes = iMes) and (fDia < iDia) then
      nAno := nAno - 1;

  if fMes < iMes then
  begin
    nMes := 12 - (iMes - fMes);
    if fDia < iDia then
      nMes := nMes - 1;
  end
  else if fMes = iMes then
  begin
    nMes := 0;
    if fDia < iDia then
      nMes := 11;
  end
  else if fMes > iMes then
  begin
    nMes := fMes - iMes;
    if fDia < iDia then
      nMes := nMes - 1;
  end;
  nDia := 0;

  if fDia > iDia then
    nDia := fDia - iDia;
  if fDia < iDia then
    nDia := (DataFim - IncMonth(DataFim, -1)) - (iDia - fDia);
  Result := '';
  if nAno = 1 then
    Result := FloatToStr(nAno) + ' Ano '
  else if nAno > 1 then
    Result := FloatToStr(nAno) + ' Anos ';

  if nMes = 1 then
    Result := Result + FloatToStr(nMes) + ' Mês '
  else if nMes > 1 then
    Result := Result + FloatToStr(nMes) + ' Meses ';

  if nDia = 1 then
    Result := Result + FloatToStr(nDia) + ' Dia '
  else if nDia > 1 then
    Result := Result + FloatToStr(nDia) + ' Dias ';

end;

Function CalculaIdade2(DataNascimento: String): Integer;
begin
  try
    StrToDate(DataNascimento); // -- Verifica se a data é valida
  except
    messagedlg('Data de nascimento inválida!', MTERROR, [MBOK], 0);
    abort;
  end;
  Result := Trunc((Date - StrToDate(DataNascimento)) / 365.25);
end;

function RetirarCaracteres(Texto, CaracteresRetirar: string): string;
var
  NovoTexto: string;
  x: Integer;
begin
  NovoTexto := '';
  for x := 1 to Length(Texto) do
  begin
    if Pos(Texto[x], CaracteresRetirar) <= 0 then
    begin
      NovoTexto := NovoTexto + Texto[x];
    end;
  end;
  Result := NovoTexto;

end;

end.
