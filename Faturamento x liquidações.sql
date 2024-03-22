SELECT
  Clientes.Nome,
  Cobranca.ID,
  Cobranca.Emissao,
  Cobranca.Numero,
  Cobranca.Valor,
  duplicata.idNota,
  duplicata.MovSeq,
  duplicata.Valor,
  FaturamentoNF.MovSeq,
  FaturamentoNF.Referencia,
  SQL.Cliente,
  SQL.BcoCobr,
  SQL.Estornado,
  SQL.Complemento,
  SQL.Valor/1,
  SQL.DataEntrada,
  SQL.Data AS Vencimento,
  SQL.Historico,
  SQL.Origem,
  SQL.Documento,
  SQL.ReferenciaFaturamento,
  SQL.BxConta,
  SQL.MotivoBaixa,
  SQL.BcoCobr,
  SQL.DataBaixa,
  SQL.BxDesconto/1,
  SQL.BxMulta/1,
  SQL.BxJuros/1,
  SQL.ValorEntrada+SQL.BxMulta+SQL.BxJuros/1
FROM Cobranca
LEFT JOIN NUPLICATA ON Cobranca.ID=NFCobr.idNota
LEFT JOIN FaturamentoNF ON DUPLICATA.MovSeq=FaturamentoNF.MovSeq
RIGHT JOIN SQL ON duplicata.MovSeq=SQL.Sequencia
LEFT JOIN Clientes ON SQL.Cliente=Clientes.Codigo
WHERE (SQL.Data BETWEEN '2020-01-01 00:00:00' AND '2020-01-31 23:59:59')
and SQL.Estornado = "n"
and SQL.Historico = "1"
and Clientes.Codigo >0
and SQL.Origem in("ser","out")
group by SQL.Documento
UNION ALL
SELECT
  Clientes.Nome,
  Cobran
