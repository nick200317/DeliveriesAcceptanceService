object DBMainModule: TDBMainModule
  Height = 121
  Width = 305
  object MainADOConnection: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=MSDASQL.1;Persist Security Info=False;User ID=root;Data' +
      ' Source=severstal;Initial Catalog=deliveriesacceptancedb'
    LoginPrompt = False
    Left = 72
    Top = 32
  end
  object MainADOQuery: TADOQuery
    Connection = MainADOConnection
    Parameters = <>
    Left = 200
    Top = 32
  end
end
