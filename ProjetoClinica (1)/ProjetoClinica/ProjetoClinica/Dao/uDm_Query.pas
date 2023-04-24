unit uDm_Query;

interface

uses
  System.SysUtils, System.Classes, uDm_Conn, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDmQuery = class(TDataModule)
    Query: TFDQuery;
    Consulta: TFDQuery;
    Paciente_Ds: TFDQuery;
    especialidades: TFDQuery;
    SelectPacientes: TFDQuery;
    Query2: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmQuery: TDmQuery;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

end.
