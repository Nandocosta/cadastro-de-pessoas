unit Repository.Pessoa.SqLite;

interface
uses
  Repository.Pessoa.Interfaces,
  Dto.Pessoa,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DApt,
  System.Generics.Collections;
Type
  TPessoaRepositorySqLite = class(TInterfacedObject, IRepositoryPessoa)
  private
    function GetQuery(ASql: String): TFDQuery;

    function GetSqlSalvar: String;
    function GetSqlExcluirPorId: String;
    function GetSqlListaDePessoas: String;
  public
    procedure Salvar(APessoaDto: TPessoaDto);
    procedure ExcluirPorId(AId: Integer);
    Function GetPessoas: TObjectList<TPessoaDto>;

  end;

implementation
  uses Database.Conexao;

{ TPessoaRepositorySqLite }

procedure TPessoaRepositorySqLite.ExcluirPorId(AId: Integer);
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

function TPessoaRepositorySqLite.GetPessoas: TObjectList<TPessoaDto>;
var
  Query: TFDquery;
  PessoaDto: TPessoaDto;
begin
  Result := TObjectList<TPessoaDto>.Create;
  Query := GetQuery(GetSqlListaDePessoas);
  try
    Query.Open;
    while not Query.Eof do
    begin
      PessoaDto := TPessoaDto.Create;
      PessoaDto.Id := Query.FieldByName('ID').AsInteger;
      PessoaDto.Nome := Query.FieldByName('NOME').AsString;
      PessoaDto.DataNascimento := Query.FieldByName('DATA_NASCIMENTO').AsDateTime;
      PessoaDto.SaldoDevedor := Query.FieldByName('SALDO_DEVEDOR').AsFloat;
      Result.Add(PessoaDto);
      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;

function TPessoaRepositorySqLite.GetQuery(ASql: String): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := DatabaseConexao.FDConn;
  Result.SQL.Text := ASql;
end;

function TPessoaRepositorySqLite.GetSqlExcluirPorId: String;
begin
  Result := 'DELETE FROM PESSOA WHERE ID = :ID';
end;

function TPessoaRepositorySqLite.GetSqlListaDePessoas: String;
begin
  Result := 'SELECT * FROM PESSOA';
end;

function TPessoaRepositorySqLite.GetSqlSalvar: String;
begin
  Result := 'INSERT INTO PESSOA ' +
            '(NOME, DATA_NASCIMENTO, SALDO_DEVEDOR) ' +
            'VALUES(:NOME, :DATA_NASCIMENTO, :SALDO_DEVEDOR)';
end;

procedure TPessoaRepositorySqLite.Salvar(APessoaDto: TPessoaDto);
var
  Query: TFDQuery;
begin
  Query := GetQuery(GetSqlSalvar);
  try
    Query.ParamByName('NOME').AsString := APessoaDto.Nome;
    Query.ParamByName('DATA_NASCIMENTO').AsDateTime := APessoaDto.DataNascimento;
    Query.ParamByName('SALDO_DEVEDOR').AsFloat := APessoaDto.SaldoDevedor;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

end.
