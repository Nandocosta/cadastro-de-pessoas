unit Repository.Pessoa.SqLite;

interface
uses
  Repository.Pessoa.Interfaces,
  Dto.Pessoa, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DApt;
Type
  TPessoaRepositorySqLite = class(TInterfacedObject, IRepositoryPessoa)
  private
    function GetQuery(ASql: String): TFDQuery;

    function GetSqlSalvar: String;
  public
    procedure Salvar(APessoaDto: TPessoaDto);

  end;

implementation
  uses Database.Conexao;

{ TPessoaRepositorySqLite }

function TPessoaRepositorySqLite.GetQuery(ASql: String): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := DatabaseConexao.FDConn;
  Result.SQL.Text := ASql;
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
