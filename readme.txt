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