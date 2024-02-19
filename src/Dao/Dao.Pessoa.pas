unit Dao.Pessoa;

interface
uses
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DApt,
  System.Generics.Collections, Model.Pessoa;
Type
  TPessoaDao = class
  private
    function GetQuery(ASql: String): TFDQuery;

    function GetSqlInserir: String;
    function GetSqlExcluirPorId: String;
    function GetSqlListaDePessoas: String;
  public
    procedure Inserir(APessoa: TPessoaModel);
    procedure ExcluirPorId(AId: Integer);
    Function GetPessoas: TObjectList<TPessoaModel>;

  end;

implementation
  uses Database.Conexao;

{ TPessoaDao }

procedure TPessoaDao.ExcluirPorId(AId: Integer);
var
  Query: TFDQuery;
begin
  Query := GetQuery(GetSqlExcluirPorId);
  try
    Query.ParamByName('ID').AsInteger := AId;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

function TPessoaDao.GetPessoas: TObjectList<TPessoaModel>;
var
  Query: TFDquery;
  Pessoa: TPessoaModel;
begin
  Result := TObjectList<TPessoaModel>.Create;

  try
    Query := GetQuery(GetSqlListaDePessoas);
    try
      Query.Open;
      while not Query.Eof do
      begin
        Pessoa := TPessoaModel.Create;
        Pessoa.Id := Query.FieldByName('ID').AsInteger;
        Pessoa.Nome := Query.FieldByName('NOME').AsString;
        Pessoa.DataNascimento := Query.FieldByName('DATA_NASCIMENTO').AsDateTime;
        Pessoa.SaldoDevedor := Query.FieldByName('SALDO_DEVEDOR').AsFloat;

        Result.Add(Pessoa);
        Query.Next;
      end;
    finally
      Query.Free;
    end;
  except
    Result.Free;
  end;
end;

function TPessoaDao.GetQuery(ASql: String): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := DatabaseConexao.FDConn;
  Result.SQL.Text := ASql;
end;

function TPessoaDao.GetSqlExcluirPorId: String;
begin
  Result := 'DELETE FROM PESSOA WHERE ID = :ID';
end;

function TPessoaDao.GetSqlListaDePessoas: String;
begin
  Result := 'SELECT * FROM PESSOA';
end;

function TPessoaDao.GetSqlInserir: String;
begin
  Result := 'INSERT INTO PESSOA ' +
            '(NOME, DATA_NASCIMENTO, SALDO_DEVEDOR) ' +
            'VALUES(:NOME, :DATA_NASCIMENTO, :SALDO_DEVEDOR)';
end;

procedure TPessoaDao.Inserir(APessoa: TPessoaModel);
var
  Query: TFDQuery;
begin
  Query := GetQuery(GetSqlInserir);
  try
    Query.ParamByName('NOME').AsString := APessoa.Nome;
    Query.ParamByName('DATA_NASCIMENTO').AsDateTime := APessoa.DataNascimento;
    Query.ParamByName('SALDO_DEVEDOR').AsFloat := APessoa.SaldoDevedor;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

end.
