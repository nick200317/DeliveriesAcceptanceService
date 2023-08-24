unit EditAcceptanceUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.DBCtrls;

type
  TEditAcceptanceForm = class(TForm)
    lblEditAcceptance: TLabel;
    lblSupplier: TLabel;
    lblDate: TLabel;
    lblComment: TLabel;
    DBLookupComboBoxSupplier: TDBLookupComboBox;
    dtpDate: TDateTimePicker;
    btnEditAcceptance: TButton;
    edtComment: TEdit;
    DataSourceSuppliers: TDataSource;
    ADOQuerySuppliers: TADOQuery;
    procedure FormShow(Sender: TObject);
    procedure btnEditAcceptanceClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EditAcceptanceForm: TEditAcceptanceForm;

implementation

{$R *.dfm}

uses DBMainModuleUnit, ClientMainUnit;

procedure TEditAcceptanceForm.btnEditAcceptanceClick(Sender: TObject);
begin
  var supplierID : integer;
  var date : TDate;
  var comment : string;

  supplierID := ADOQuerySuppliers.FieldByName('UserID').AsInteger;
  date := dtpDate.Date;
  comment := edtComment.Text;

  if(supplierID = 0) then MessageDlg('Check supplier!', mtError, [mbOK], 0)
  else
  begin
    try
      DBMainModule.MainADOQuery.SQL.Clear;
      DBMainModule.MainADOQuery.SQL.Add('update Acceptances set SupplierID = :supplierID, Date = :date, Comment = :comment where AcceptanceID = :acceptanceID;');
      DBMainModule.MainADOQuery.Parameters.ParamByName('supplierID').Value := supplierID;
      DBMainModule.MainADOQuery.Parameters.ParamByName('date').Value := FormatDateTime('yyyy-mm-dd', date);
      DBMainModule.MainADOQuery.Parameters.ParamByName('comment').Value := comment;
      DBMainModule.MainADOQuery.Parameters.ParamByName('acceptanceID').Value := ClientMainForm.ADOQueryAcceptances.FieldByName('AcceptanceID').AsInteger;
      DBMainModule.MainADOQuery.ExecSQL;

      MessageDlg('The acceptance has been successfully updated!', mtInformation, [mbOk], 0);
    except on ex : Exception do
     MessageDlg(ex.Message, mtError, [mbOk], 0);
    end;
  end;
end;

procedure TEditAcceptanceForm.FormShow(Sender: TObject);
begin
  try
    ADOQuerySuppliers.Active := false;
    ADOQuerySuppliers.Active := true;
    ADOQuerySuppliers.FieldByName('Fio').DisplayWidth := 20;

    DBLookupComboBoxSupplier.KeyValue := ClientMainForm.ADOQueryAcceptances.FieldByName('Supplier').AsString;
    dtpDate.Date := ClientMainForm.ADOQueryAcceptances.FieldByName('Date').AsDateTime;
    edtComment.Text := ClientMainForm.ADOQueryAcceptances.FieldByName('Comment').AsString;
  except on ex : Exception do
     MessageDlg(ex.Message, mtError, [mbOk], 0);
  end;
end;

end.
