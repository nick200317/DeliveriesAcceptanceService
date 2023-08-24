unit RegUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, StrUtils, System.Hash,
  Vcl.ExtCtrls;

type
  TRegForm = class(TForm)
    lblReg: TLabel;
    lblFIO: TLabel;
    edtFIO: TEdit;
    lblPhone: TLabel;
    lblINN: TLabel;
    edtINN: TEdit;
    lblLogin: TLabel;
    edtLogin: TEdit;
    lblPassword: TLabel;
    edtPassword: TEdit;
    edtConfirmPassword: TEdit;
    lblConfirmPassword: TLabel;
    btnReg: TButton;
    btnBackToAuth: TButton;
    mEdtPhone: TMaskEdit;
    rgType: TRadioGroup;
    procedure btnBackToAuthClick(Sender: TObject);
    procedure btnRegClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegForm: TRegForm;

implementation

{$R *.dfm}

uses DBMainModuleUnit;

// Функция проверки логина пользователя на существование в базе при регистрации
function CheckUserInDatabase(login : string) : bool;
begin
  var sqlResult : Integer;

  DBMainModule.MainADOQuery.Active := false;
  DBMainModule.MainADOQuery.SQL.Clear;
  DBMainModule.MainADOQuery.SQL.Add('select count(*) as checkCount from users where Login = :login;');
  DBMainModule.MainADOQuery.Parameters.ParamByName('login').Value := login;
  DBMainModule.MainADOQuery.Active := true;

  sqlResult := DBMainModule.MainADOQuery.FieldByName('checkCount').AsInteger;

  if(sqlResult = 0) then Result := false
  else Result := true;
end;

procedure TRegForm.btnBackToAuthClick(Sender: TObject);
begin
  Close();
end;

procedure TRegForm.btnRegClick(Sender: TObject);
begin
  var fio, phone, inn, login, password, confirmPassword, userType : string;

  fio := trim(edtFIO.Text);
  phone := trim(mEdtPhone.Text);
  inn := trim(edtINN.Text);
  login := trim(edtLogin.Text);
  password := trim(edtPassword.Text);
  confirmPassword := trim(edtConfirmPassword.Text);

  if(rgType.ItemIndex	= 0) then userType := 'Client'
  else userType := 'Supplier';

  if(fio = '') then MessageDlg('Check your Full name!', mtError, [mbOK], 0)
  else if(ContainsStr(phone, ' ')) then MessageDlg('Check your Phone!', mtError, [mbOK], 0)
  else if(inn = '') then MessageDlg('Check your INN!', mtError, [mbOK], 0)
  else if(login = '') then MessageDlg('Check your Login!', mtError, [mbOK], 0)
  else if(password = '') then MessageDlg('Check your Password!', mtError, [mbOK], 0)
  else if(confirmPassword = '') then MessageDlg('Confirm your Password!', mtError, [mbOK], 0)
  else if(password <> confirmPassword) then MessageDlg('Password don''t match!', mtError, [mbOK], 0)
  else if(length(password) < 10) then MessageDlg('The minimum password length is 10 characters!', mtError, [mbOK], 0)
  else
  begin
    if(CheckUserInDatabase(login)) then MessageDlg('The login already exists!', mtError, [mbOK], 0)
    else
    begin
      try
        password := THashSHA2.GetHashString(password, THashSHA2.TSHA2Version.SHA256);

        DBMainModule.MainADOQuery.SQL.Clear;
        DBMainModule.MainADOQuery.SQL.Add('insert into users values(null, :fio, :phone, :inn, :login, :password, :type);');
        DBMainModule.MainADOQuery.Parameters.ParamByName('fio').Value := fio;
        DBMainModule.MainADOQuery.Parameters.ParamByName('phone').Value := phone;
        DBMainModule.MainADOQuery.Parameters.ParamByName('inn').Value := inn;
        DBMainModule.MainADOQuery.Parameters.ParamByName('login').Value := login;
        DBMainModule.MainADOQuery.Parameters.ParamByName('password').Value := password;
        DBMainModule.MainADOQuery.Parameters.ParamByName('type').Value := userType;
        DBMainModule.MainADOQuery.ExecSQL;

        MessageDlg('The user was created successfully!', mtInformation, [mbOK], 0);

        Close();
      except on ex : Exception do
          MessageDlg(ex.Message, mtError, [mbOK], 0);
      end;
    end;
  end;
end;

end.
