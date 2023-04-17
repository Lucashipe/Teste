unit U_IndexMedico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.StdCtrls,
  Vcl.WinXCtrls, Vcl.Imaging.jpeg, Vcl.ExtCtrls, uDm_Login, Vcl.WinXCalendars,
  Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TFormMedico = class(TForm)
    Panel2: TPanel;
    Panel1: TPanel;
    Image3: TImage;
    Panel11: TPanel;
    ToggleSwitch1: TToggleSwitch;
    Panel6: TPanel;
    Panel12: TPanel;
    Panel7: TPanel;
    Panel13: TPanel;
    Panel8: TPanel;
    Panel14: TPanel;
    Panel9: TPanel;
    Panel15: TPanel;
    Panel3: TPanel;
    lb_funcionario: TLabel;
    Label1: TLabel;
    PPicPerfil: TPanel;
    Image2: TImage;
    PNewPaciente: TPanel;
    Panel5: TPanel;
    Panel4: TPanel;
    Pnl_Body: TPanel;
    Pnl_Agenda: TPanel;
    Pnl_AgHeader: TPanel;
    DBGrid1: TDBGrid;
    Panel10: TPanel;
    Panel16: TPanel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMedico: TFormMedico;

implementation

{$R *.dfm}

procedure TFormMedico.FormShow(Sender: TObject);
begin
  lb_funcionario.caption := DmLogin.FDQuery1.FieldByName('login').AsString;
end;

end.
