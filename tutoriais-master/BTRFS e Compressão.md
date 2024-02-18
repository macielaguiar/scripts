
#### BTRFS E COMPRESSÃO


##Comandos para aplicar compressão no disco:

sudo find . -type d -exec btrfs property set {} compression zstd \;
sudo mount -o compress=zstd /dev/sdX /mnt

##Comando para aplicar compressão numa pasta:

sudo btrfs filesystem defrag -r -v -czstd .



##COMPRESSÃO

Btrfs oferece suporte à compactação transparente de arquivos. Existem três algoritmos disponíveis: ZLIB, LZO e ZSTD (desde v4.14), com vários níveis. A compactação acontece no nível das extensões do arquivo e o algoritmo é selecionado pela propriedade do arquivo, opção de montagem ou por um comando de desfragmentação. Você pode ter um único ponto de montagem btrfs que tenha alguns arquivos descompactados, alguns compactados com LZO, outros com ZLIB, por exemplo (embora você possa não querer dessa forma, ele é suportado).

Assim que a compactação for definida, todos os dados recém-gravados serão compactados, ou seja, os dados existentes permanecerão intactos. Os dados são divididos em pedaços menores (128 KB) antes da compactação para possibilitar reescritas aleatórias sem afetar o alto desempenho. Devido ao aumento do número de extensões o consumo de metadados é maior. Os pedaços são compactados em paralelo.

Os algoritmos podem ser caracterizados da seguinte forma em relação às compensações velocidade/relação:

ZLIB
taxa de compressão mais lenta e mais alta

níveis: 1 a 9, mapeados diretamente, o nível padrão é 3

boa compatibilidade com versões anteriores

LZO
compactação e descompactação mais rápida que ZLIB, pior taxa de compactação, projetada para ser rápida

sem níveis

boa compatibilidade com versões anteriores

ZSTD
compressão comparável ao ZLIB com velocidades de compressão/descompressão mais altas e proporção diferente

níveis: 1 a 15, mapeados diretamente (níveis mais altos não estão disponíveis)

desde 4.14, níveis desde 5.1

As diferenças dependem do conjunto de dados real e não podem ser expressas por um único número ou recomendação. Níveis mais altos consomem mais tempo de CPU e podem não trazer uma melhoria significativa, níveis mais baixos estão próximos do tempo real.


COMO HABILITAR A COMPACTAÇÃO

Normalmente a compactação pode ser habilitada em todo o sistema de arquivos, especificado para o ponto de montagem. Observe que as opções de montagem de compactação são compartilhadas entre todas as montagens do mesmo sistema de arquivos, sejam montagens de ligação ou montagens de subvolume. Consulte a seção btrfs(5) MOUNT OPTIONS .

$ mount -o compress=zstd /dev/sdx /mnt
Isso ativará o zstdalgoritmo no nível padrão (que é 3). O nível também pode ser especificado manualmente como zstd:3. Níveis mais altos comprimem melhor ao custo do tempo. Isso, por sua vez, pode causar aumento na latência de gravação, níveis baixos são adequados para compactação em tempo real e em CPU razoavelmente rápida não causam quedas perceptíveis de desempenho.

$ btrfs filesystem defrag -czstd file
O comando acima iniciará a desfragmentação de todo o arquivo e aplicará a compactação, independente da opção de montagem. (Nota: a especificação do nível ainda não foi implementada). O algoritmo de compactação não é persistente e se aplica apenas ao comando de desfragmentação; para qualquer outra gravação, outras configurações de compactação se aplicam.

As configurações persistentes por arquivo podem ser definidas de duas maneiras:

$ chattr +c file
$ btrfs property set file compression zstd
O primeiro comando usa interface herdada de atributos de arquivo herdados do sistema de arquivos ext2 e não é flexível, portanto, por padrão, a compactação zlib é definida. O outro comando define uma propriedade no arquivo com o algoritmo fornecido. (Observação: definir o nível dessa forma ainda não foi implementado.)


NÍVEIS DE COMPRESSÃO

O suporte de nível ZLIB foi adicionado na v4.14, LZO não suporta níveis (a implementação do kernel fornece apenas um), o suporte de nível ZSTD foi adicionado na v5.1.

Existem 9 níveis de ZLIB suportados (1 a 9), mapeando 1:1 da opção de montagem para o nível definido pelo algoritmo. O padrão é o nível 3, que fornece uma taxa de compactação razoavelmente boa e ainda é razoavelmente rápido. A diferença no ganho de compressão dos níveis 7, 8 e 9 é comparável, mas os níveis mais elevados demoram mais.

O suporte ZSTD inclui os níveis 1 a 15, um subconjunto da gama completa do que o ZSTD oferece. Os níveis 1-3 são em tempo real, 4-8 mais lentos com compactação aprimorada e 9-15 tentam ainda mais, embora o tamanho resultante possa não ser significativamente melhorado.

O nível 0 sempre mapeia para o padrão. O nível de compactação não afeta a compatibilidade.


DADOS INCOMPRESSÍVEIS

Arquivos com dados já compactados ou com dados que não serão compactados bem com as restrições de CPU e memória das implementações do kernel estão usando uma lógica de decisão simples. Se a primeira parte dos dados compactados não for menor que a original, a compactação do arquivo será desativada - a menos que o sistema de arquivos seja montado com compress-force . Nesse caso, a compactação sempre será tentada no arquivo para ser posteriormente descartada. Isto não é ideal e está sujeito a otimizações e desenvolvimento adicional.

Se um arquivo for identificado como incompressível, um sinalizador será definido ( NOCOMPRESS ) e será fixo. Nesse arquivo, a compactação não será executada, a menos que seja forçada. A flag também pode ser definida por chattr +m (desde e2fsprogs 1.46.2) ou por propriedades com valor no ou none . O valor vazio irá redefini-lo para o padrão atualmente aplicável no sistema de arquivos montado.

Existem duas maneiras de detectar dados incompressíveis:

tentativa de compactação real - os dados são compactados, se o resultado não for menor, eles são descartados, então isso depende do algoritmo e do nível

heurística de pré-compressão - é realizada uma rápida avaliação estatística dos dados e com base no resultado a compressão é realizada ou ignorada, o bit NOCOMPRESS não é definido apenas pela heurística, apenas se o algoritmo de compressão não fizer uma melhoria

$ lsattr file
---------------------m file
O uso da compactação forçada não é recomendado, a heurística deve decidir isso e os algoritmos de compactação também detectam internamente dados incompressíveis.


HEURÍSTICAS DE PRÉ-COMPRESSÃO

As heurísticas visam fazer alguns testes estatísticos rápidos nos dados comprimidos, a fim de evitar uma compressão provavelmente dispendiosa que se revelaria ineficiente. Os algoritmos de compactação também podem ter detecção interna de dados incompressíveis, mas isso leva a mais sobrecarga, pois a compactação é feita em outro thread e precisa gravar os dados de qualquer maneira. A heurística é somente leitura e pode utilizar memória cache.

Os testes foram realizados com base no seguinte: amostragem de dados, detecção de padrões repetidos longos, frequência de bytes, entropia de Shannon.


COMPATIBILIDADE

A compactação é feita usando o mecanismo COW, portanto é incompatível com nodatacow . O Direct IO funciona em arquivos compactados, mas retornará às gravações em buffer e levará à recompactação. Atualmente nodatasum e compactação não funcionam juntos.

Os algoritmos de compressão foram adicionados ao longo do tempo, portanto a compatibilidade da versão também deve ser considerada, juntamente com outras ferramentas que podem acessar os dados compactados, como bootloaders.