SELECT
NFCab.Modelo AS MODELO,
NFCab.Serie AS SERIE,
NFCab.Numero AS NUMERO,
NFCab.ChaveAcesso AS CHAVE_ACESSO,
date_format(NFCab.Emissao,'%d/%m/%Y')AS EMISSAO,
Clientes.CNPJ_CNPF AS CNPJ_CPF,
Clientes.Tipo,
ClienteGrupo.Descricao,
Clientes.UF AS ESTADO,
Clientes.Nome AS CLIENTE,
Planos.Descricao AS PLANO,
Planos.Velocidade,
ContratosEndereco.Cidade as Instalação,
format(VlrNota,2,'de_DE') AS VALOR,
format(VlrNota * 0.0065,2,'de_DE') AS PIS,
format(VlrNota * 0.03,2, 'de_DE') AS COFINS
FROM Clientes
INNER JOIN Contratos on Clientes.codigo=Contratos.cliente
left JOIN Planos on Contratos.Plano=Planos.Codigo
Inner join NFCab on Clientes.Codigo=NFCab.clifor
left join ClienteGrupo on Clientes.Grupo=ClienteGrupo.Codigo
left join ContratosEndereco on Clientes.Codigo=ContratosEndereco.Cliente
left join ContratosMotivos on Contratos.Motivo=ContratosMotivos.id
WHERE (NFCab.Emissao BETWEEN '2021-05-01 00:00:00' AND '2021-05-31 23:59:59')
AND NFCab.Modelo ="21"
and NFCab.Situacao in ("7","0")
group by NFCab.Numero
