SELECT
cobranca.Modelo AS MODELO,
cobranca.Serie AS SERIE,
cobranca.Numero AS NUMERO,
cobranca.ChaveAcesso AS CHAVE_ACESSO,
date_format(cobranca.Emissao,'%d/%m/%Y')AS EMISSAO,
Clientes.CNPJ_CNPF AS CNPJ_CPF,
Clientes.Tipo,
ClienteGrupo.Descricao,
Clientes.UF AS ESTADO,
Clientes.Nome AS CLIENTE,
Planos.Descricao AS PLANO,
Planos.speed,
Contratos_Endereco.Cidade as Instalação,
format(VlrNota,2,'de_DE') AS VALOR,
format(VlrNota * 0.0065,2,'de_DE') AS PIS,
format(VlrNota * 0.03,2, 'de_DE') AS COFINS
FROM Clientes
INNER JOIN Contratos on Clientes.codigo=Contratos.cliente
left JOIN Planos on Contratos.Plano=Planos.Codigo
Inner join cobranca on Clientes.Codigo=NFCab.clifor
left join Cliente_Grupo on Clientes.Grupo=ClienteGrupo.Codigo
left join Contratos_Endereco on Clientes.Codigo=ContratosEndereco.Cliente
left join Contratos_Motivos on Contratos.Motivo=ContratosMotivos.id
WHERE (cobranca.Emissao BETWEEN '2021-05-01 00:00:00' AND '2021-05-31 23:59:59')
AND cobranca.Modelo ="21"
and cobranca.Situacao in ("7","0")
group by cobranca.Numero
