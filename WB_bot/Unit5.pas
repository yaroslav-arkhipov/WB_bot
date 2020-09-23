unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdTCPConnection,
  IdTCPClient, IdHTTP, IdBaseComponent, IdComponent, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, Vcl.OleCtrls,
  SHDocVw, IdCookieManager;

type
  TForm5 = class(TForm)
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    IdHTTP1: TIdHTTP;
    Button1: TButton;
    Memo1: TMemo;
    Edit1: TEdit;
    Edit2: TEdit;
    Button2: TButton;
    Button3: TButton;
    Edit3: TEdit;
    IdCookieManager1: TIdCookieManager;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;
  detectClk: integer;
implementation

{$R *.dfm}

procedure TForm5.Button1Click(Sender: TObject);
var respStr,link, tempStr:string;
log:TStringStream;
begin
  link:='{"username":"'+Edit1.Text+'","password":"'+Edit2.Text+'","captcha_id":null,"captcha_solution":""}';
  log:=TStringStream.Create(Utf8Encode(link));
  IdHTTP1.Request.ContentType:='application/json';
  IdHTTP1.Request.CharSet := 'utf-8';
  respStr:=IdHTTP1.Post('https://suppliers.wildberries.ru/api/login', log);
  Memo1.Lines.Add('['+Timetostr(time)+']'+'�����������...');
  if pos('userId', respStr)<>0 then
  begin
    Memo1.Lines.Add('['+Timetostr(time)+']'+'����������� ������ �������');
    tempStr:=respStr;
    Delete(tempStr,1,pos('userId',tempStr));
    Delete(tempStr,1,pos(':',tempStr));
    Delete(tempStr,pos(',',tempStr),tempStr.Length-1);
    Memo1.Lines.Add('['+Timetostr(time)+']'+'User ID: '+tempStr);
    tempStr:=respStr;
    Delete(tempStr,1,pos('phone',tempStr));
    Delete(tempStr,1,pos(':',tempStr)+1);
    Delete(tempStr,pos('}',tempStr),tempStr.Length-1);
    Memo1.Lines.Add('['+Timetostr(time)+']'+'�������: '+tempStr);
    detectClk:=1;
  end
  else
    begin
    Memo1.Lines.Add('['+Timetostr(time)+']'+'������ �����������');
    detectClk:=0;
    end;
end;

procedure TForm5.Button2Click(Sender: TObject);
var s:string;
begin
s:=IdHTTP1.Get('https://suppliers.wildberries.ru/logout');
Memo1.Lines.Add('['+Timetostr(time)+']'+'����� �� ��������');
detectClk:=0;
end;

procedure TForm5.Button3Click(Sender: TObject);
var s:string;
respStr, request1, request2, request3, tempStr:string;
log:TStringStream;
begin
if detectClk=1 then
begin
  s:=IdHTTP1.Get('https://suppliers.wildberries.ru/product-card-api/api/v1/product-card/web/nm/find?nm='+Edit3.Text+'');
  if pos('sa', s)<>0 then
  begin
   Memo1.Lines.Add('['+Timetostr(time)+']'+'����� ������');
   Delete(s,1,pos('sa',s));
   Delete(s,1,pos(':',s));
   Delete(s,pos(',',s),s.Length-1);
   Memo1.Lines.Add('['+Timetostr(time)+']'+'������� ������: '+s);
   request1:=IdHTTP1.Get('https://suppliers.wildberries.ru/product-card-api/api/v1/product-card/web/card?by=1&value='+Edit3.Text+'');
    Delete(request1, pos('p',request1), (pos('t',request1)));
    Insert('"origin":', request1, pos('"',request1));
    Delete(request1,pos(':',request1)+1,1);
    Delete(request1,pos('isSupplierEnv',request1)-2,request1.Length);
    request2:=request1;
    Delete(request2, pos('{',request2), (pos('n',request2)));
    Insert(',"edited":', request2, pos('{',request2));
    Delete(request2, 1, (pos(',',request2))-1);
    //Delete(request2,pos('"text":',request2)+8,pos('"}',request2));
    Memo2.Lines.Add(request2);
    Insert(Timetostr(time), request2, pos('"text":',request2)+8);
    request3:=request1+request2+',"comment":"","imtProblem":0}';
 //request2:='{"entity_id":52622,"entity_name":"Beijing Kamiershangpin International Trade Co., Ltd.","nm_id":13927988,"supplier_id":0}';
 log:=TStringStream.Create(Utf8Encode(request3));
 IdHTTP1.Request.ContentType:='application/json';
 IdHTTP1.Request.CharSet := 'utf-8';
 respStr:=IdHTTP1.Post('https://suppliers.wildberries.ru/product-card-api/api/v1/product-card/test/card/save', log);
 if pos('"errors":null', respStr)<>0 then
   Memo1.Lines.Add('['+Timetostr(time)+']'+'��������� ������� �������')
 else
  Memo1.Lines.Add('['+Timetostr(time)+']'+'�������� ������');
  end;
end;
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
Memo1.Lines.Clear;
IdSSLIOHandlerSocketOpenSSL1.SSLOptions.Method:=sslvTLSv1_2;
end;

end.
