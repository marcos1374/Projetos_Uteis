import pandas as pd

# Carregar as planilhas
planilha1 = pd.read_excel('planilha_modelo_1.xlsx')
planilha2 = pd.read_excel('planilha_modelo_2.xlsx')

# Obter descrições únicas de cada planilha
descricoes_planilha1 = set(planilha1['Descrição'])
descricoes_planilha2 = set(planilha2['Descrição'])

# Encontrar descrições exclusivas em ambas as planilhas
descricoes_exclusivas = descricoes_planilha1.symmetric_difference(descricoes_planilha2)

# Criar DataFrame com descrições exclusivas
df_descricoes_exclusivas = pd.DataFrame({'Descrição': list(descricoes_exclusivas)})

# Salvar as descrições exclusivas em uma nova planilha
df_descricoes_exclusivas.to_excel('diferencas.xlsx', index=False)

print("Produtos exclusivos identificados e salvos em 'diferencas.xlsx'.")
