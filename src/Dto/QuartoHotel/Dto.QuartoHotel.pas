unit Dto.QuartoHotel;

interface

uses
  System.Generics.Collections;

type

TCaracteristicaDto = class
  private
    FId: Integer;
    FNome: String;
  public
    property Id: Integer read FId write FId;
    property Nome: String read FNome write FNome;
end;


TQuartoHotelDto = class
  private
    FCodigo: String;
    FNome: String;
    FPreco: Double;
    FCaracteristicas: TObjectList<TCaracteristicaDto>;
  public
    property Codigo: String read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property Preco: Double read FPreco write FPreco;
    property Caracteristicas: TObjectList<TCaracteristicaDto> read FCaracteristicas write FCaracteristicas;

    constructor Create;
    destructor Destroy;override;
end;


implementation

{ TQuartoHotelDto }

constructor TQuartoHotelDto.Create;
begin
  FCaracteristicas := TObjectList<TCaracteristicaDto>.Create;
end;

destructor TQuartoHotelDto.Destroy;
begin
  FCaracteristicas.Free;
end;

end.
