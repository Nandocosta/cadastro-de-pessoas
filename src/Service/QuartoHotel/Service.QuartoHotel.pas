unit Service.QuartoHotel;

interface
uses
  Dto.QuartoHotel,
  System.Generics.Collections,
  Service.QuartoHotel.Interfaces,
  IdHTTP,
  IdComponent,
  IdSSLOpenSSL;



type

TQuartoHotelServico = class(TInterfacedObject, IQuartoHotelServico)
  private
    FIdHTTP: TIdHTTP;
    FIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
  public
    function Buscar: TObjectList<TQuartoHotelDto>;

    constructor Create;

end;

implementation

uses
  System.JSON, System.SysUtils;

{ TQuartoHotelServico }

function TQuartoHotelServico.Buscar: TObjectList<TQuartoHotelDto>;
var
  JsonQuartoHotel: String;

  JsonArrayQuartoHotel: TJSONArray;
  JsonArrayCaracteristicas: TJSONArray;

  IndexQuartoHotel: Integer;
  IndexCaracteristicas: Integer;

  QuartoHotelDto: TQuartoHotelDto;
  CaracteristicaDto: TCaracteristicaDto;
begin
  Result := TObjectList<TQuartoHotelDto>.Create;

  JsonQuartoHotel := FIdHTTP.Get('https://run.mocky.io/v3/c20be17a-bc5c-4736-a5e5-dbcff9591b5a');

  JsonArrayQuartoHotel := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JsonQuartoHotel), 0) as TJSONArray;

  for IndexQuartoHotel := 0 to Pred(JsonArrayQuartoHotel.Size) do
  begin
    QuartoHotelDto := TQuartoHotelDto.Create;
    QuartoHotelDto.Codigo := JsonArrayQuartoHotel[IndexQuartoHotel].GetValue<string>('codigo', '');
    QuartoHotelDto.Nome := JsonArrayQuartoHotel[IndexQuartoHotel].GetValue<string>('nome', '');
    QuartoHotelDto.Preco := JsonArrayQuartoHotel[IndexQuartoHotel].GetValue<Double>('preco', 0);

    JsonArrayCaracteristicas := JsonArrayQuartoHotel[IndexQuartoHotel].GetValue<TJSONArray>('caracteristicas');

    for IndexCaracteristicas := 0 to Pred(JsonArrayCaracteristicas.Size) do
    begin
      CaracteristicaDto := TCaracteristicaDto.Create;
      CaracteristicaDto.Id := JsonArrayCaracteristicas[IndexCaracteristicas].GetValue<Integer>('id', 0);
      CaracteristicaDto.Nome := JsonArrayCaracteristicas[IndexCaracteristicas].GetValue<String>('nome', '');

      QuartoHotelDto.Caracteristicas.Add(CaracteristicaDto);
    end;

    Result.Add(QuartoHotelDto);
  end;
end;

constructor TQuartoHotelServico.Create;
begin
  FIdHTTP := TIdHTTP.Create;
  FIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.Method := sslvSSLv2;
  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2, sslvSSLv2];
  FIdHttp.IOHandler := FIdSSLIOHandlerSocketOpenSSL;
  FIdHttp.Request.ContentType := 'application/json';
  FIdHttp.HandleRedirects := True;
end;

end.
