!-------------------!               Descrição do Programa             !-------------------!

Basicamente, o usuário chama pela função main, e ela solicita a inserção de algumas informações:
- a largura e altura da imagem gerada. respectivos 'w' e 'h'.
- número de formas geradas, o 'n'.
- o tipo de formas geradas, o 't';
- 'c' que é cor das formas geradas, onde pode se escolher uma cor fixa rgb ou cores aleatórios, ou ainda uma paleta de cinzas aleatórios.
- 'f' se deseja ou não que as formas sejam preenchidas.

Define-se fill como True se f for "y" ou False se não.

Então declara o valor da 'points' referente a forma escolhida, isto é, o número de casas utilizadas do vetor de pontos (x,y) por forma.

E atribui os vetores de inteiros gerados de maneira radômica os purificando para as seguintes variáveis

rxList ---> lista responsável por conter os valores do eixo x dos pontos, é gerado um valor aleatório entre 1 e w (a largura da imagem) para cada n vezes points
ryList ---> a mesma coisa que a anterior, mas para o eixo y.

reds, greens, blues ---> cada um sendo o vetor que será utilizado em conjunto com os outros para definir o rgb das formas.

grays ---> se o usuário escolher a paleta de cores cinza para as formas, atribui o mesmo valor do indice x para ambas as três própriedades do rgb, poderia ter sido feito reaproveitado ou o reds ou o blues ou o grens, já que nesse cenário eles não são utilizados, mas quis separar tudo certinho.

sizes ---> define um vetor de tamanhos de raios aleatorios entre 1 e 100 para caso o usuário deseje circulos.

Define o colors de acordo com o valor inserido pelo usuário em c.

Define svgBody de acordo com o tipo de forma que foi escolhida (Linhas quebradas, Linhas Curvadas ou Circulos), chamando a função correspondente gen 
que gera uma lista de strings, cada uma sendo uma tag svg com suas determinadas caracteristicas, depois utiliza a função intercalate que basicamente pega todas as strings da lista e concatena
podendo imprimir as svg na forma de svgBody, entre o  svgBegin e svgEnd, gerando nossa linda arte!

Dica: a paleta de cores cinza fica incrível junto com a linhas curvadas preenchidas!

o svg anexado como exemplo foi confeccionado com os seguintes parametros:
w: 1300
h: 700
n: 200
t: s
c: g
f: y








!-------------------!       Adversidades enfrentadas durante o Desenvolvimento       !-------------------!


Inicialmente eu utilizei as funções anteriormente utilizadas svgBegin, svgEnd e svgPath.
posteriormente eu fiquei estudando por horas como implementar o randomIO, finailmente consigo faze-lo criando um project
com o cabal e declarando o pacote random como dependencia.

Então descobri que o haskell impossibilita pegar valores Int randomicos dessa mesma biblioteca, pelo que eu entendi
ele os traduz como IO Int, para manter a pureza matematica da linguagem e impedir efeitos colaterais, ou seja, o fato
da base matematica do haskell implica que: uma função f que recebe um parametro x deve retornar sempre o mesmo y como resposta
assim como na matemática.

Então o retorno da função randomRIO não pode ser trabalhado diretamente dentro das funções, a não ser que se desabilite o modo
seguro que impede esses efeitos colaterais, mas a função ainda retorna um tipo IO Int, tal tipo que basicamente age como
uma instrução de como pegar aquele número randomico, que pode ser executada dentro de um do block e convertida para um Int quando
atribuida através da setinha '<-', assim eu consegui gerar um path randomico, entretanto, enfrentei dificuldades até então, em fazer isso
com uma lista para repetir o processo diversas vezes.

Estudando finalmente descobri que o tipo IO de outro tipo nada mais representa do que a forma de se conseguir um dado daquele tipo,
como foi citado anteriormente, a pureza funcional do haskell impede que suas funções retornem um dado aleatório, entretanto, ele permite a 
existencia de instruções para se conseguir tais dados, exemplificando, um dado do tipo IO Int, é basicamente uma instrução de como conseguir um Inteiro
especifico.
Instrução? mas Haskell não é uma linguagem declarativa? sim, ele impede você de utilizar aquela imperatividade classica, mas ele também
reconhece que a própria arquitetura de Von neumann na qual nossos computadores são construídos trabalha com esse modelo,
então, ele permite que você passe essa "receita de dado", IO Int por exemplo, através da utilização do "do" que vai purificar ele, resultando em um Int.

Então, dentro do "do" se pode "purificar" os valores IO da seguinte forma:
IO Int -> Int
Então eu poderia converter a minha instrução de como conseguir uma lista de valores inteiros ( IO [Int] ) oriunda da função randoRIO para uma lista de valores Inteiros.
Entretanto, utilizando o randomRIO repetidas vezes, eu não possuia um IO [Int] e sim um [IO Int], isto é, eu não possuia a "receita pra se conseguir uma lista de determinados inteiros", eu possui uma "lista de receitas para se conseguir um determinado inteiro";;
Existiam funções específicas que retornavam um lista de números pseudo-aleatórios, mas invés de ficar filtrando-os para conseguir um outra lista com números entre a e b,
eu queria utilizar a própria randomRIO que já me retornava um valor entre a e b.

Para manter o uso do randomRIO, pois meus números aleatórios deveriam ser entre 1 e x e 1 e y para poder posicionar na imagem
sendo x a width da mesma e y a altura, eu encontrei a função sequence que é uma função monadica que é descrita por:
[m a] -> m [a] 
então eu pensei: ela recebe um vetor de valores x y e me retorna um vetor de tipo x de valores y.
e finalmente cheguei na conclusão que meus vetor de [IO Int] poderia ser convertido para um IO [Int].

Como recebi alguns parametros por input, utilizei diversas vezes o read para converter o parametro para outro tipo na hora de passar para uma função,
por exemplo read x :: Int converte x para Int.

PERGUNTA
essa receita de como conseguir um dado, o que ela seria exatamente?

Eu estava pensando que seria um número especifico que quando processado retornasse um determinado dado, por isso ele é "purificado".


