unit U_Conexao;

interface

uses
  FireDAC.Comp.Client, FireDAC.Stan.Intf, System.SysUtils;

type

  TConexao = class

  private
    FServidor: string;
    FMsgErro: string;
    FSenha: string;
    FBase: string;
    FLogin: string;
    FPorta: string;
    FConexao: TFDConnection;
  public

    constructor Create(NomeConexao: TFDConnection);
    destructor Destroy; override;

    function Conec_Bd: Boolean;

    property Conexao: TFDConnection Read FConexao Write FConexao;
    property Servidor: string read FServidor write FServidor;
    property Base: string read FBase write FBase;
    property Login: string read FLogin write FLogin;
    property Senha: string read FSenha write FSenha;
    property Porta: string read FPorta write FPorta;
    property MsgErro: string read FMsgErro write FMsgErro;

  end;

implementation

{ TConexao }

  constructor TConexao.Create(NomeConexao: TFDConnection);
  begin
  FConexao := NomeConexao;
  end;

  destructor TConexao.Destroy;
  begin
  FConexao.Connected := false;
  inherited;
  end;

  function TConexao.Conec_Bd: Boolean;
  begin
  Result := True;

  FConexao.Params.Clear;

  FConexao.Params.Add('Server=' + FServidor);
  FConexao.Params.Add('user_name=' + FLogin);
  FConexao.Params.Add('password=' + FSenha);
  FConexao.Params.Add('porta=' + FPorta);
  FConexao.Params.Add('Database=' + FBase);
  FConexao.Params.Add('DriverID=' + 'Pg');

  try
  FConexao.Connected := True;
  Except
  on e: Exception do
  begin
  FMsgErro := e.Message;
  Result := false;

  end;

  end;
  end;

end.
