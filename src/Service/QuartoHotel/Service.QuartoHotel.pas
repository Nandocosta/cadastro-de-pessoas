unit Service.QuartoHotel;

interface
uses
  Model.QuartoHotel,
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
    function Buscar: TObjectList<TQuartoHotelModel>;

    constructor Create;
    destructor Destroy;override;

end;

implementation

uses
  System.JSON, System.SysUtils;

{ TQuartoHotelServico }

function TQuartoHotelServico.Buscar: TObjectList<TQuartoHotelModel>;
var
  JsonQuartoHotel: String;

  JsonArrayQuartoHotel: TJSONArray;
  JsonArrayCaracteristicas: TJSONArray;

  IndexQuartoHotel: Integer;
  IndexCaracteristicas: Integer;

  QuartoHotel: TQuartoHotelModel;
  Caracteristica: TCaracteristicaModel;
begin
  Result := TObjectList<TQuartoHotelModel>.Create;

  JsonQuartoHotel := FIdHTTP.Get('https://run.mocky.io/v3/c20be17a-bc5c-4736-a5e5-dbcff9591b5a');

  JsonArrayQuartoHotel := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JsonQuartoHotel), 0) as TJSONArray;
  try
    for IndexQuartoHotel := 0 to Pred(JsonArrayQuartoHotel.Count) do
    begin
      QuartoHotel := TQuartoHotelModel.Create;
      QuartoHotel.Codigo := JsonArrayQuartoHotel[IndexQuartoHotel].GetValue<string>('codigo', '');
      QuartoHotel.Nome := JsonArrayQuartoHotel[IndexQuartoHotel].GetValue<string>('nome', '');
      QuartoHotel.Preco := JsonArrayQuartoHotel[IndexQuartoHotel].GetValue<Double>('preco', 0);

      JsonArrayCaracteristicas := JsonArrayQuartoHotel[IndexQuartoHotel].GetValue<TJSONArray>('caracteristicas');

      for IndexCaracteristicas := 0 to Pred(JsonArrayCaracteristicas.Count) do
      begin
        Caracteristica := TCaracteristicaModel.Create;
        Caracteristica.Id := JsonArrayCaracteristicas[IndexCaracteristicas].GetValue<Integer>('id', 0);
        Caracteristica.Nome := JsonArrayCaracteristicas[IndexCaracteristicas].GetValue<String>('nome', '');

        QuartoHotel.Caracteristicas.Add(Caracteristica);
      end;

      Result.Add(QuartoHotel);
    end;
  finally
    JsonArrayQuartoHotel.Free;
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

destructor TQuartoHotelServico.Destroy;
begin
  FIdSSLIOHandlerSocketOpenSSL.Free;
  FIdHttp.Free;
  inherited;
end;

end.
