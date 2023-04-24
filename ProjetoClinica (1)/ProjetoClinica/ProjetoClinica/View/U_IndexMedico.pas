unit U_IndexMedico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.StdCtrls,
  Vcl.WinXCtrls, Vcl.Imaging.jpeg, Vcl.ExtCtrls, uDm_Login, Vcl.WinXCalendars,
  Data.DB, Vcl.Grids, Vcl.DBGrids, ComObj, uDm_Query, uDm_Funcionarios;

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
    db_Medico: TDBGrid;
    Panel10: TPanel;
    Panel16: TPanel;
    Button1: TButton;
    Medico: TDataSource;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1Click(Sender: TObject);
    procedure db_MedicoCellClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMedico: TFormMedico;
  Nome: string;
  Sobrenome: string;

implementation

{$R *.dfm}

procedure TFormMedico.db_MedicoCellClick(Column: TColumn);
begin
  Nome := DmFuncionarios.ds_Medico.FieldByName('nome').AsString;
  Sobrenome := DmFuncionarios.ds_Medico.FieldByName('sobrenome').AsString;
end;

procedure TFormMedico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TFormMedico.FormShow(Sender: TObject);
begin
  DmQuery.Query.SQL.Clear;
  DmQuery.Query.SQL.add
    ('Select * from medicos where func_id = :id_funcionario');
  DmQuery.Query.ParamByName('id_funcionario').AsInteger :=
    DmLogin.FDQuery1.FieldByName('id_funcionario').AsInteger;
  DmQuery.Query.open;

  lb_funcionario.caption := DmLogin.FDQuery1.FieldByName('login').AsString;
  DmFuncionarios.ds_Medico.SQL.Clear;
  DmFuncionarios.ds_Medico.SQL.add
    ('select * from consultas left join pacientes on id_pct = paciente_id left join pessoa_fisica on pf_id = id_pf Where medico_id = :id_medico');
  DmFuncionarios.ds_Medico.ParamByName('id_medico').AsInteger :=
    DmQuery.Query.FieldByName('id_medico').AsInteger;
  DmFuncionarios.ds_Medico.open;
end;

procedure TFormMedico.Image1Click(Sender: TObject);
begin
  self.Close;
end;

procedure TFormMedico.Button1Click(Sender: TObject);
var
  voz: OleVariant;
begin
  if (Nome <> '') and (Sobrenome <> '') then
  begin
    if True then

      voz := CreateOleObject('SAPI.SpVoice');
    voz.Speak('Paciente' + Nome + ' ' + Sobrenome +
      'Favor comparecer no consultorio 6');
  end
  else
  begin
    ShowMessage('Selecione um Paciente');
  end;

end;

end.
