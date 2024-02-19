unit Model.QuartoHotel;

interface

uses
  System.Generics.Collections;

type

TCaracteristicaModel = class
  private
    FId: Integer;
    FNome: String;
  public
    property Id: Integer read FId write FId;
    property Nome: String read FNome write FNome;
end;


TQuartoHotelModel = class
  private
    FCodigo: String;
    FNome: String;
    FPreco: Double;
    FCaracteristicas: TObjectList<TCaracteristicaModel>;
  public
    property Codigo: String read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property Preco: Double read FPreco write FPreco;
    property Caracteristicas: TObjectList<TCaracteristicaModel> read FCaracteristicas write FCaracteristicas;

    constructor Create;
    destructor Destroy;override;
end;


implementation

{ TQuartoHotelModel }

constructor TQuartoHotelModel.Create;
begin
  FCaracteristicas := TObjectList<TCaracteristicaModel>.Create;
end;

destructor TQuartoHotelModel.Destroy;
begin
  FCaracteristicas.Free;
end;

end.
