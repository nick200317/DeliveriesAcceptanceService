unit DBMainModuleUnit;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB, Data.DBXMySQL,
  Data.SqlExpr;

type
  TDBMainModule = class(TDataModule)
    MainADOConnection: TADOConnection;
    MainADOQuery: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DBMainModule: TDBMainModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
