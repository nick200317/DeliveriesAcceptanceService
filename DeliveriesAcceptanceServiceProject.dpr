program DeliveriesAcceptanceServiceProject;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {AuthForm},
  RegUnit in 'RegUnit.pas' {RegForm},
  DBMainModuleUnit in 'DBMainModuleUnit.pas' {DBMainModule: TDataModule},
  SupplierMainUnit in 'SupplierMainUnit.pas' {SupplierMainForm},
  AddProductUnit in 'AddProductUnit.pas' {AddProductForm},
  EditProductUnit in 'EditProductUnit.pas' {EditProductForm},
  AddPriceUnit in 'AddPriceUnit.pas' {AddPriceForm},
  EditPriceUnit in 'EditPriceUnit.pas' {EditPriceForm},
  ClientMainUnit in 'ClientMainUnit.pas' {ClientMainForm},
  AddAcceptanceUnit in 'AddAcceptanceUnit.pas' {AddAcceptanceForm},
  AcceptanceItemsUnit in 'AcceptanceItemsUnit.pas' {AcceptanceItemsForm},
  AddAcceptanceItemUnit in 'AddAcceptanceItemUnit.pas' {AddAcceptanceItemForm},
  EditAcceptanceItemUnit in 'EditAcceptanceItemUnit.pas' {EditAcceptanceItemForm},
  EditAcceptanceUnit in 'EditAcceptanceUnit.pas' {EditAcceptanceForm},
  ReportsMainUnit in 'ReportsMainUnit.pas' {ReportsMainForm},
  ReportProductsUnit in 'ReportProductsUnit.pas' {ReportProductsForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TAuthForm, AuthForm);
  Application.CreateForm(TRegForm, RegForm);
  Application.CreateForm(TDBMainModule, DBMainModule);
  Application.CreateForm(TSupplierMainForm, SupplierMainForm);
  Application.CreateForm(TAddProductForm, AddProductForm);
  Application.CreateForm(TEditProductForm, EditProductForm);
  Application.CreateForm(TAddPriceForm, AddPriceForm);
  Application.CreateForm(TEditPriceForm, EditPriceForm);
  Application.CreateForm(TClientMainForm, ClientMainForm);
  Application.CreateForm(TAddAcceptanceForm, AddAcceptanceForm);
  Application.CreateForm(TAcceptanceItemsForm, AcceptanceItemsForm);
  Application.CreateForm(TAddAcceptanceItemForm, AddAcceptanceItemForm);
  Application.CreateForm(TEditAcceptanceItemForm, EditAcceptanceItemForm);
  Application.CreateForm(TEditAcceptanceForm, EditAcceptanceForm);
  Application.CreateForm(TReportsMainForm, ReportsMainForm);
  Application.CreateForm(TReportProductsForm, ReportProductsForm);
  Application.Run;
end.
