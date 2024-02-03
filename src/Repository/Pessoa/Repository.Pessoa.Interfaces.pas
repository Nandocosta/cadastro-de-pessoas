unit Repository.Pessoa.Interfaces;

interface

uses Dto.Pessoa;
  type
    IRepositoryPessoa = interface
      ['{1248950D-DF2A-4CEF-ACEF-ADB10082F5A6}']
      procedure Salvar(APessoaDto: TPessoaDto);
    end;
implementation

end.
