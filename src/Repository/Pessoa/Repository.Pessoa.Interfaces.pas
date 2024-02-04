unit Repository.Pessoa.Interfaces;

interface

uses
  Dto.Pessoa,
  System.Generics.Collections;
  type
    IRepositoryPessoa = interface
      ['{1248950D-DF2A-4CEF-ACEF-ADB10082F5A6}']
      procedure Salvar(APessoaDto: TPessoaDto);
      procedure ExcluirPorId(AId: Integer);
      Function GetPessoas: TObjectList<TPessoaDto>;
    end;
implementation

end.
