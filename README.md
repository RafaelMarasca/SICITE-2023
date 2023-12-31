# SICITE-2023

## Extração de Escalogramas e Cromagramas a partir dos arquivos de áudio

Para gerar os espectrogramas, basta rodar o script get_images.m e apontar 
o diretório onde estão os dados musicais e, em seguida, o diretório onde 
as imagens serão salvas. 

Os dados obtidos estão contidos na pasta ./data/features/spectrogram.


## Obtenção das medidas topológicas

O scritp getFeatures.m gera uma matriz contendo as medidas de coeficiente
de agrupamento, grau médio dos vértices e sortividade geradas a partir das
imagens. Estes dados estão nessa ordem, onde cada linha da matriz corresponde 
a uma imagem analisada.

Opcionalmente, pode-se obter um vetor contendo o nome dos arquivos e um vetor
contendo a classe do dado (assume-se que a pasta de onde a imagem foi extraída
possui o nome da classe).
Assim, basta rodá-lo e apontar o diretório de onde serão extraídas as imagens. 

## Classificador

O classificador construído pode ser rodado a partir do script classifier.py.
Ele busca o arquivo features.csv na pasta ./data/features. Esse arquivo é uma
tabela gerada a partir da concatenação das matrizes de topologia dos cromagramas
e dos espectrogramas para 10% das músicas do bando GTZAN. 