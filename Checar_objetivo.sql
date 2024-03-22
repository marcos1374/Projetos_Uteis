SELECT
  Clients.CNPJ_CNPF,
  NFCab.Numero AS Invoice_Number, # Número da Nota Fiscal.
  Clients.Sigla AS Business_Name,
  Contracts.Client,
  Clients.Nome,
  Clients.Grupo,
  CASE
    WHEN Clients.Grupo IN ('21','35','36','44','63') THEN 'Provider'
    WHEN Clients.Grupo IN ('54','69','66') THEN 'Resale'
    WHEN Clients.Grupo IN ('68','34','49','48','37','14','38','4','24','31','9','32','5','68','67','64','45','46','47','39','30','25','22','18','19','7','6','2','1') THEN 'Corporate'
    WHEN Clients.Grupo IN ('55', '65','60') THEN 'Government'
    ELSE 'Check'
  END,
  ClienteGrupo.Descricao AS Grupo,
  FaturamentoNota.Referencia, # Informação de referencia do mês de emissão.
  DATE_FORMAT(NFCab.Emissao, '%d/%m/%Y') AS Emissao, # Data de Emissão da Nota Fisca.
  Planos.Descricao,
  Planos.Velocidade,
  CASE
    WHEN Planos.Velocidade >= '102400' THEN 'Provider'
    ELSE 'Corporate'
  END,
  ContratosEndereco.Cidade AS Inslacao,
  FORMAT(VlrNota, 2, 'de_DE') AS VALOR, # Valor total da Nota Fiscal.
  DATE_FORMAT(Movimento.Data, '%d/%m/%Y') AS Vencimento, # Data de Vencimento.
  Movimento.Documento,
  FORMAT(Movimento.BxDesconto, 2, 'de_DE') AS Desconto,
  FORMAT(Movimento.BxMulta, 2, 'de_DE') AS Multa,
  FORMAT(Movimento.BxJuros, 2, 'de_DE') AS Juros,
  FORMAT(Movimento.ValorEntrada + Movimento.BxMulta + Movimento.BxJuros, 2, 'de_DE') AS Total # Valor total somando o valor + Multa + Juros - Desconto.
FROM NFCab
LEFT JOIN NFCobr ON NFCab.ID = NFCobr.idNota
LEFT JOIN FaturamentoNota ON NFCobr.MovSeq = FaturamentoNota.MovSeq
RIGHT JOIN Movimento ON NFCobr.MovSeq = Movimento.Sequencia
LEFT JOIN Clientes ON Movimento.Cliente = Clientes.Codigo
INNER JOIN Contratos ON NFCab.CliFor = Contratos.Cliente
INNER JOIN Planos ON FaturamentoNota.Plano = Planos.Codigo
LEFT JOIN ClienteGrupo ON Clientes.Grupo = ClienteGrupo.Codigo
LEFT JOIN ContratosEndereco ON Clientes.Codigo = ContratosEndereco.Cliente
WHERE (NFCab.Emissao BETWEEN '2020-11-01 00:00:00' AND '2020-11-31 23:59:59')
AND NFCab.Modelo = "21"
AND NFCab.Situacao IN ("7","0")
GROUP BY NFCab.Numero
