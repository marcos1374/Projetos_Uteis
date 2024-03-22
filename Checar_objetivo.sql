select
Clientes.CNPJ_CNPF,
NFCab.Numero as Nota_Fiscal, # Número da Nota Fiscal.
Clientes.Sigla as Nome_Fantasia,
Contratos.Cliente,
Clientes.Nome,
Clientes.Grupo,
case
when Clientes.Grupo in ('21','35','36','44','63') then 'Provedor'
when Clientes.Grupo in ('54','69','66') then 'Revenda'
when Clientes.Grupo in ('68','34','49','48','37','14','38','4','24','31','9','32','5','68','67','64','45','46','47','39','30','25','22','18','19','7','6','2','1') then 'Corporativo'
when Clientes.Grupo in ('55', '65','60') then 'Governo'
else 'Checar'
end,
ClienteGrupo.Descricao as Grupo,
FaturamentoNota.Referencia, # Informação de referencia do mês de emissão.
date_format(NFCab.Emissao,'%d/%m/%Y')AS Emissâo, # Data de Emissão da Nota Fisca.
Planos.Descricao,
Planos.Velocidade,
case
when Planos.Velocidade >='102400' then 'Provedor'
else 'Corporativo'
end,
ContratosEndereco.Cidade as Inslacao,
format(VlrNota,2,'de_DE') AS VALOR, # Valor total da Nota Fiscal.
date_format(Movimento.Data,'%d/%m/%Y')AS Vencimento, # Data de Vencimento.
Movimento.Documento,
format(Movimento.BxDesconto,2,'de_DE') as Desconto,
format(Movimento.BxMulta,2,'de_DE') as Multa,
format(Movimento.BxJuros,2,'de_DE') as Juros,
format(Movimento.ValorEntrada+Movimento.BxMulta+Movimento.BxJuros,2,'de_DE') as Total # Valor total somando o valor + Multa + Juros - Desconto.
from NFCab
left join NFCobr on NFCab.ID=NFCobr.idNota
left join FaturamentoNota on NFCobr.MovSeq=FaturamentoNota.MovSeq
right join Movimento on NFCobr.MovSeq=Movimento.Sequencia
left JOIN Clientes ON Movimento.Cliente=Clientes.Codigo
inner join Contratos on NFCab.CliFor=Contratos.Cliente
inner join Planos on FaturamentoNota.Plano=Planos.Codigo
left join ClienteGrupo on Clientes.Grupo=ClienteGrupo.Codigo
left join ContratosEndereco on Clientes.Codigo=ContratosEndereco.Cliente
where (NFCab.Emissao BETWEEN '2020-11-01 00:00:00' AND '2020-11-31 23:59:59')
AND NFCab.Modelo ="21"
and NFCab.Situacao in ("7","0")
group by NFCab.Numero