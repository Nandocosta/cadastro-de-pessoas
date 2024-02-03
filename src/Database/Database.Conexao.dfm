object DatabaseConexao: TDatabaseConexao
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 170
  Width = 360
  object FDConn: TFDConnection
    Params.Strings = (
      
        'Database=F:\Cadastro de clientes\cadastro-de-pessoas\banco.sqlit' +
        'e'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 48
    Top = 40
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 216
    Top = 32
  end
end
