object DmQuery: TDmQuery
  OldCreateOrder = False
  Height = 150
  Width = 215
  object Query: TFDQuery
    Connection = DataModule1.FDConnection1
    Left = 24
    Top = 8
  end
  object Consulta: TFDQuery
    Connection = DataModule1.FDConnection1
    SQL.Strings = (
      
        'Select * From consultas left join pacientes on paciente_id = id_' +
        'pct left join pessoa_fisica on pacientes.pf_id = id_pf left join' +
        ' medicos on consultas.medico_id = medicos.id_medico left join fu' +
        'ncionarios on id_funcionario = medicos.func_id left join pessoa_' +
        'fisica pessoa_fisica2 on funcionarios.pf_id = pessoa_fisica2.id_' +
        'pf')
    Left = 24
    Top = 72
  end
  object Paciente_Ds: TFDQuery
    Connection = DataModule1.FDConnection1
    SQL.Strings = (
      'Select * from pacientes left join pessoa_fisica on id_pf = pf_id')
    Left = 88
    Top = 16
  end
  object especialidades: TFDQuery
    Connection = DataModule1.FDConnection1
    SQL.Strings = (
      'select * from especialidades')
    Left = 88
    Top = 72
  end
  object SelectPacientes: TFDQuery
    Connection = DataModule1.FDConnection1
    Left = 160
    Top = 24
  end
  object Query2: TFDQuery
    Active = True
    Connection = DataModule1.FDConnection1
    SQL.Strings = (
      
        'SELECT * FROM consultas left join pacientes on paciente_id = id_' +
        'pct left join pessoa_fisica on id_pf = pf_id Left join medicos o' +
        'n id_medico = medico_id left join funcionarios on func_id = id_f' +
        'uncionario left join pessoa_fisica pessoa_fisica2 on funcionario' +
        's.pf_id = pessoa_fisica2.id_pf')
    Left = 160
    Top = 80
  end
end
