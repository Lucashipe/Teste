object DmFuncionarios: TDmFuncionarios
  OldCreateOrder = False
  Height = 150
  Width = 215
  object FDQuery1: TFDQuery
    Active = True
    Connection = DataModule1.FDConnection1
    SQL.Strings = (
      
        'select * from funcionarios left join pessoa_fisica on pf_id = id' +
        '_pf')
    Left = 64
    Top = 56
  end
  object Update: TFDQuery
    Connection = DataModule1.FDConnection1
    Left = 144
    Top = 48
  end
end
