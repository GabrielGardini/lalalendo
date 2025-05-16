//
//  Story.swift
//  lalalendo
//
//  Created by Sofia Villas Bôas on 16/05/25.
//

import Foundation

struct MockData {
    static let stories = [
        Chapter(id: 1,
                text: "Em um belo dia, você decide caminhar por uma estrada. Mas se depara com dois caminhos.",
                question: "Qual você escolhe?",
                imageName: "id1 - default",
                choices:
                    [Choice(id: 1, title: "Cidade", buttonImage: "id1 opcao1", nextChapterId: 2),
                     Choice(id: 2, title: "Floresta", buttonImage: "id1 opcao2", nextChapterId: 3)]),
        
        Chapter(id: 2,
                text: "Ao chegar na cidade, percebe que ela está toda sem cores! Tudo é cinza, triste e sem graça. As casas, o céu, e até mesmo o parquinho.",
                question: "Qual parte você quer explorar?",
                imageName: "id2 default",
                choices: [
                    Choice(id: 1, title: "Casas", buttonImage: "id2 opcao1", nextChapterId: 4),
                    Choice(id: 2, title: "Parquinho", buttonImage: "id2 opcao2", nextChapterId: 5)
                ]),
        
        Chapter(id: 3,
                text: "Ao chegar na floresta, encontra dois animais: um cachorrinho que parece estar perdido e um mico leão dourado deitado no galho de uma árvore.",
                question: "Com qual animal você quer falar?",
                imageName: "id3 default",
                choices: [
                    Choice(id: 1, title: "Cão", buttonImage: "id3 opcao1", nextChapterId: 6),
                    Choice(id: 2, title: "Mico", buttonImage: "id3 opcao2", nextChapterId: 7)
                ]),
        
        Chapter(id: 4,
                text: "Você anda em direção a uma casa, e ao entrar nela, você encontra dois presentes!",
                question: "Qual você escolhe?",
                imageName: "id4 default",
                choices: [
                    Choice(id: 1, title: "Redondo", buttonImage: "id4 opcao1", nextChapterId: 8),
                    Choice(id: 2, title: "Quadrado", buttonImage: "id4 opcao2", nextChapterId: 9)
                ]),
        
        Chapter(id: 5,
                text: "Chegando no parquinho, você encontra seu amigo com seu cachorrinho Lulu que foge para a floresta de repente!",
                question: "Você vai atrás de Lulu ou ficar com seu amigo?",
                imageName: "id5 default",
                choices: [
                    Choice(id: 1, title: "Amigo", buttonImage: "id5 opcao1", nextChapterId: 10),
                    Choice(id: 2, title: "Cão", buttonImage: "id5 opcao2", nextChapterId: 11)
                ]),
        
        Chapter(id: 6,
                text: "Você ia falar com o cãozinho, mas ele correu. Você o segue até o parquinho e encontra seu amigo, que diz que o cachorro é dele, mas está triste demais para procurá-lo.",
                question: "Ficar com seu amigo ou procurar o cãozinho?",
                imageName: "id6 default",
                choices: [
                    Choice(id: 1, title: "Amigo", buttonImage: "id6 opcao1", nextChapterId: 12),
                    Choice(id: 2, title: "Cão", buttonImage: "id6 opcao2", nextChapterId: 13)
                ]),
        
        Chapter(id: 7,
                text: "O mico te mostra a floresta mágica. Tudo é muito bonito, tem flores e animais encantados! Você quer explorar tudo, mas vê seu amigo ao longe, bem triste porque seu cãozinho fugiu.",
                question: "Ficar com seu amigo ou explorar a floresta?",
                imageName: "id7 default",
                choices: [
                    Choice(id: 1, title: "Amigo", buttonImage: "id7 opcao1", nextChapterId: 14),
                    Choice(id: 2, title: "Floresta", buttonImage: "id7 opcao2", nextChapterId: 15)
                ]),
        
        Chapter(id: 8,
                text: "De dentro da caixa redonda, pula um cachorrinho! Mas não um cachorro comum, ele é todo colorido! Juntos, vocês colorem a cidade com as cores do arco-íris. Cada traço era um pedacinho de alegria, e quem passava ficava mais feliz. Desde então, ninguém esqueceu: um pouco de cor pode encher o mundo de felicidade!",
                question: "",
                imageName: "id8 default",
                choices: []),
        
        Chapter(id: 9,
                text: "Você abre a caixa e encontra vários lápis de cor! Com brilho nos olhos, decide dar fim à cidade cinza, pintando o céu de azul e os muros de amarelo-sol. Cada traço era um pedacinho de alegria, e quem passava ficava mais feliz. Desde então, ninguém esqueceu: um pouco de cor pode encher o mundo de felicidade!",
                question: "",
                imageName: "id9 default",
                choices: []),
        
        Chapter(id: 10,
                text: "Você vai até a casa do seu amigo e encontra o cachorrinho, agora todo colorido! Enquanto estava perdido, ele encontrou uma fruta mágica e, ao comer, se transformou em um arco-íris de pelos. Juntos, com a ajuda do cachorrinho, vocês pintaram a cidade, espalhando alegria e cores por todo lado.",
                question: "",
                imageName: "id10 default",
                choices: []),
        
        Chapter(id: 11,
                text: "Você descobre que a floresta é encantada e tudo lá é colorido, você encontra o cachorrinho lá, todo feliz e cheio de cores! Juntos, decidem levar a magia para a cidade, espalhando tinta e alegria por onde passam. Cada traço de cor transforma a cidade, deixando tudo mais bonito e brilhante.",
                question: "",
                imageName: "id11 default",
                choices: []),
        
        Chapter(id: 12,
                text: "Você vê que seu amigo está triste e decide ficar com ele. Você pode continuar no parquinho ou levá-lo para casa.",
                question: "O que você faz?",
                imageName: "id12 default",
                choices: [
                    Choice(id: 1, title: "Parquinho", buttonImage: "id12 opcao1", nextChapterId: 16),
                    Choice(id: 2, title: "Casa", buttonImage: "id12 opcao2", nextChapterId: 16)
                ]),
        
        Chapter(id: 13,
                text: "O cachorro correu para a floresta e você decidiu segui-lo. Lá, encontra uma árvore enorme que te dá uma vista de toda a floresta e também algumas pegadas.",
                question: "Qual delas você prefere explorar?",
                imageName: "id13 default",
                choices: [
                    Choice(id: 1, title: "Árvore", buttonImage: "id13 opcao1", nextChapterId: 17),
                    Choice(id: 2, title: "Pegadas", buttonImage: "id13 opcao2", nextChapterId: 17)
                ]),
        
        Chapter(id: 14,
                text: "Você encontra seu amigo, bem triste, com saudades de seu cachorrinho. Você pode levá-lo para casa ou esperar juntos na floresta até ele se sentir melhor?",
                question: "O que você vai fazer?",
                imageName: "id14 default",
                choices: [
                    Choice(id: 1, title: "Casa", buttonImage: "id14 opcao1", nextChapterId: 16),
                    Choice(id: 2, title: "Floresta", buttonImage: "id14 opcao2", nextChapterId: 16)
                ]),
        
        Chapter(id: 15,
                text: "Na floresta mágica, você encontra vários animais encantados brincando felizes. Você pode se juntar a eles ou continuar procurando o cachorrinho?",
                question: "O que você prefere?",
                imageName: "id15 default",
                choices: [
                    Choice(id: 1, title: "Brincar", buttonImage: "id15 opcao1", nextChapterId: 17),
                    Choice(id: 2, title: "Procurar cão", buttonImage: "id15 opcao2", nextChapterId: 17)
                ]),
        
        Chapter(id: 16,
                text: "Enquanto você fazia companhia pro seu amigo, o cachorrinho voltou correndo e pulou nos braços dele! Eles se reencontraram cheios de alegria, e todos brincaram juntos na floresta encantada. Às vezes, esperar com carinho é tudo o que um amigo precisa.",
                question: "",
                imageName: "id16 default",
                choices: []),
        
        Chapter(id: 17,
                text: "Você encontra o cachorrinho e se encanta com suas cores, ele parecia um arco-íris, brincando feliz com outros bichinhos na floresta mágica. Então, você entende que aquele era o verdadeiro lar dele, e que, às vezes, amar é deixar quem a gente gosta ser feliz onde realmente pertence.",
                question: "",
                imageName: "id17 default",
                choices: []),        
    ]
}
