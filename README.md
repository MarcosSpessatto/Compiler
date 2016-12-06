# Transpiler from CT language to Java

#**RUN**
jflex LexicalAnalyzer.flex
yacc -J Parser.y
javac *.java
java Parser file

####Systax of Ct Language
// Programa de teste da Linguagem CT

// Declaracao de Classes

classe Aluno {
	inteiro num, num_notas
	vetor inteiro notas[30]

	// funcoes da classe aluno

	real media()
	{
		inteiro total, i
		real media

		se (i=2) {
			i<-3
		}
		total<-0 
		i<-0

		enquanto (i<num_notas) 
		{ 
  			total<-total+notas[i]
  			i<-i+1
		}

		media<-total/i

		_ media
	}

	inteiro adiciona(inteiro nota)
	{
		se ( num<30 ) {
			notas[num_notas]<-nota
  			num_notas<-num_notas+1
  			_ 1
		} senao {
			escrever("erro")
  			_ -1
		} 
	}

	nulo aluno() 
	{
		inteiro i

		para(i<-0 ate i<30 passo i<-i+1 ) {
			notas[i]<-0
		}

  		num_notas<-0
  		num<-0
	}
}

subclasse aluno1 {aluno} {

	inteiro propinas
	inteiro pago

	// funcoes da classe aluno1

	nulo aluno1()
	{
		propinas<-0
		pago<-0
	}

	inteiro deve()
	{
		inteiro temp

		temp<-propinas-deve

		escrever(temp)
		_ temp
	}
}

classe testa{

	funcao_principal {
		real b
		aluno1 al1

		b <- al1.media()

  		escrever(b)

  		al1.propina<-100000
		al1.pago<-25000
		al1.deve()
	}
}
