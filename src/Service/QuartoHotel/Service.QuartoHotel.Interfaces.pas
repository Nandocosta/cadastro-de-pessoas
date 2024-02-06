unit Service.QuartoHotel.Interfaces;

interface

uses
  System.Generics.Collections, Dto.QuartoHotel;

type

ICaracteristicaDto = interface
  ['{AFE04E91-FAF2-48AE-A3D0-9D226C4B6B11}']
end;

IQuartoHotelServico = interface
  ['{47A81157-9763-49A1-AECF-717BE75DFB43}']
  function Buscar: TObjectList<TQuartoHotelDto>;
end;

implementation

end.
