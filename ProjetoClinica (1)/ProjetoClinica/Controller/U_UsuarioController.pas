unit U_UsuarioController;

interface

uses U_UsuarioModel;

type
  TUsuarioController = class
  private
    { private declarations }
  protected
    { protected declarations }
  public
    function Inserir(oUsuario: TUsuario; var sErro: string): Boolean;

  published
    { published declarations }
  end;

implementation

{ TUsuarioController }

function TUsuarioController.Inserir(oUsuario: TUsuario;
  var sErro: string): Boolean;
begin

end;

end.
