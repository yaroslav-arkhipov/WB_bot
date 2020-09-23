object Form5: TForm5
  Left = 0
  Top = 0
  Caption = 'WB bot'
  ClientHeight = 200
  ClientWidth = 785
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 62
    Width = 177
    Height = 25
    Caption = 'Log in'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 191
    Top = 8
    Width = 280
    Height = 185
    Lines.Strings = (
      '')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 8
    Top = 8
    Width = 177
    Height = 21
    TabOrder = 2
    TextHint = 'Login'
  end
  object Edit2: TEdit
    Left = 8
    Top = 35
    Width = 177
    Height = 21
    TabOrder = 3
    TextHint = 'Password'
  end
  object Button2: TButton
    Left = 8
    Top = 93
    Width = 177
    Height = 25
    Caption = 'Log out'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 168
    Width = 177
    Height = 25
    Caption = 'Autoedit product'
    TabOrder = 5
    OnClick = Button3Click
  end
  object Edit3: TEdit
    Left = 8
    Top = 135
    Width = 177
    Height = 21
    TabOrder = 6
    TextHint = 'Number of product'
  end
  object Memo2: TMemo
    Left = 477
    Top = 8
    Width = 300
    Height = 186
    Lines.Strings = (
      'Memo2')
    ScrollBars = ssVertical
    TabOrder = 7
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmClient
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 288
    Top = 112
  end
  object IdHTTP1: TIdHTTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    AllowCookies = True
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.ContentType = #39'application/json'#39
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    CookieManager = IdCookieManager1
    Left = 160
    Top = 64
  end
  object IdCookieManager1: TIdCookieManager
    Left = 528
    Top = 88
  end
end
