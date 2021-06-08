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
