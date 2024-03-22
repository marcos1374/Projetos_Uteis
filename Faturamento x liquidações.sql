select
Clientes.Nome,
NFCab.ID,
NFCab.Emissao,
NFCab.Numero,
NFCab.VlrNota,
NFCobr.idNota,
NFCobr.MovSeq,
NFCobr.Valor,
FaturamentoNota.MovSeq,
FaturamentoNota.Referencia,
Movimento.Cliente,
Movimento.BcoCobr,
Movimento.Estornado,
Movimento.Complemento,
Movimento.Valor/1,
Movimento.DataEntrada,
Movimento.Data as Vencimento,
Movimento.Historico,
Movimento.Origem,
Movimento.Documento,
Movimento.ReferenciaFaturamento,
Movimento.BxConta,
Movimento.MotivoBaixa,
Movimento.BcoCobr,
Movimento.DataBaixa,
Movimento.BxDesconto/1,
Movimento.BxMulta/1,
Movimento.BxJuros/1,
Movimento.ValorEntrada+Movimento.BxMulta+Movimento.BxJuros/1
from NFCab
left join NFCobr on NFCab.ID=NFCobr.idNota
left join FaturamentoNota on NFCobr.MovSeq=FaturamentoNota.MovSeq
right join Movimento on NFCobr.MovSeq=Movimento.Sequencia
left JOIN Clientes ON Movimento.Cliente=Clientes.Codigo
WHERE (Movimento.Data BETWEEN '2020-01-01 00:00:00' AND '2020-01-31 23:59:59')
and Movimento.Estornado = "n"
and Movimento.Historico = "1"
and Clientes.Codigo >0
and Movimento.Origem in("ser","out")
group by Movimento.Documento
UNION ALL
select
Clientes.Nome,
NFCab.ID,
NFCab.Emissao,
NFCab.Numero,
NFCab.VlrNota,
NFCobr.idNota,
NFCobr.MovSeq,
NFCobr.Valor,
FaturamentoNota.MovSeq,
FaturamentoNota.Referencia,
Movimento.Cliente,
Movimento.BcoCobr,
Movimento.Estornado,
Movimento.Complemento,
Movimento.Valor/1,
Movimento.DataEntrada,
Movimento.Data as Vencimento,
Movimento.Historico,
Movimento.Documento,
Movimento.Origem,
Movimento.ReferenciaFaturamento,
Movimento.BxConta,
Movimento.MotivoBaixa,
Movimento.BcoCobr,
Movimento.DataBaixa,
Movimento.BxDesconto/1,
Movimento.BxMulta/1,
Movimento.BxJuros/1,
Movimento.ValorEntrada+Movimento.BxMulta+Movimento.BxJuros/1
from NFCab
left join NFCobr on NFCab.ID=NFCobr.idNota
left join FaturamentoNota on NFCobr.MovSeq=FaturamentoNota.MovSeq
right join Movimento on NFCobr.MovSeq=Movimento.Sequencia
left JOIN Clientes ON Movimento.Cliente=Clientes.Codigo
where (NFCab.Emissao BETWEEN '2020-01-01 00:00:00' AND '2020-01-31 23:59:59')
and Movimento.Estornado = "n"
and Movimento.Historico = "1"
and Clientes.Codigo >0
group by Movimento.Documento