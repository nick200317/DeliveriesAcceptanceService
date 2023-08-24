unit AcceptanceItemsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh,
  Data.DB, Data.Win.ADODB, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh;

type
  TAcceptanceItemsForm = class(TForm)
    lblAcceptanceItemsForm: TLabel;
    pnlAcceptanceItemsActions: TPanel;
    imgDeleteAcceptanceItem: TImage;
    imgAddAcceptanceItem: TImage;
    imgEditAcceptanceItem: TImage;
    DBGridAcceptanceItems: TDBGridEh;
    DataSourceAcceptanceItems: TDataSource;
    ADOQueryAcceptanceItems: TADOQuery;
    procedure imgDeleteAcceptanceItemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgAddAcceptanceItemClick(Sender: TObject);
    procedure imgEditAcceptanceItemClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    AcceptanceID, SupplierID : integer;
    AcceptanceDate : TDate;
  end;

var
  AcceptanceItemsForm: TAcceptanceItemsForm;

implementation

{$R *.dfm}

uses DBMainModuleUnit, AddAcceptanceItemUnit, EditAcceptanceItemUnit;

// Процедура обновления элементов (продукции) приёмки.
procedure UpdateAcceptanceItems();
begin
  var i : integer;

  try
    AcceptanceItemsForm.ADOQueryAcceptanceItems.SQL.Clear;
    AcceptanceItemsForm.ADOQueryAcceptanceItems.SQL.Add('select AcceptanceItemID, Types.Name as Type, Products.Sort, Weight from AcceptanceItems Join Prices on AcceptanceItems.PriceID = Prices.PriceID ');
    AcceptanceItemsForm.ADOQueryAcceptanceItems.SQL.Add('Join Products on Prices.ProductID = Products.ProductID Join Types on Products.TypeID = Types.TypeID where AcceptanceID = :id;');
    AcceptanceItemsForm.ADOQueryAcceptanceItems.Parameters.ParamByName('id').Value := AcceptanceItemsForm.AcceptanceID;

    AcceptanceItemsForm.ADOQueryAcceptanceItems.Active := false;
    AcceptanceItemsForm.ADOQueryAcceptanceItems.Active := true;

    for i := 0 to AcceptanceItemsForm.DBGridAcceptanceItems.Columns.Count-1 do
    begin
      AcceptanceItemsForm.DBGridAcceptanceItems.Columns[i].OptimizeWidth;
      AcceptanceItemsForm.DBGridAcceptanceItems.Columns[i].Alignment := taCenter;
    end;
  except on ex : Exception do
     MessageDlg(ex.Message, mtError, [mbOk], 0);
  end;
end;

procedure TAcceptanceItemsForm.FormShow(Sender: TObject);
begin
  UpdateAcceptanceItems();
end;

procedure TAcceptanceItemsForm.imgAddAcceptanceItemClick(Sender: TObject);
begin
  AddAcceptanceItemForm := TAddAcceptanceItemForm.Create(Self);

  AddAcceptanceItemForm.ShowModal();
  UpdateAcceptanceItems();
end;

procedure TAcceptanceItemsForm.imgDeleteAcceptanceItemClick(Sender: TObject);
begin
  var confirmDelete, i : integer;

  if(DBGridAcceptanceItems.SelectedRows.Count = 0) then MessageDlg('Select row to delete item!', mtInformation, [mbOK], 0)
  else
  begin
    confirmDelete := MessageDlg('Do you really want to delete the item?', TMsgDlgType.mtConfirmation, mbOKCancel, 0);

    if(confirmDelete = mrOk) then
    begin
      DBMainModule.MainADOQuery.SQL.Clear;
      DBMainModule.MainADOQuery.SQL.Add('delete from AcceptanceItems where AcceptanceItemID = :id');
      DBMainModule.MainADOQuery.Parameters.ParamByName('id').Value := ADOQueryAcceptanceItems.FieldByName('AcceptanceItemID').AsInteger;
      DBMainModule.MainADOQuery.ExecSQL;

      UpdateAcceptanceItems();
    end;
  end;
end;

procedure TAcceptanceItemsForm.imgEditAcceptanceItemClick(Sender: TObject);
begin
  if(DBGridAcceptanceItems.SelectedRows.Count = 0) then MessageDlg('Select row to update the item!', mtInformation, [mbOK], 0)
  else
  begin
    EditAcceptanceItemForm := TEditAcceptanceItemForm.Create(Self);

    EditAcceptanceItemForm.ShowModal();
    UpdateAcceptanceItems();
  end;
end;

end.
