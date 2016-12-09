# Transpiler from CT language to Java

Transpiler written using (Jflex and Byacc/J) , for academic purposes of computer science course.

#**RUN**
jflex LexicalAnalyzer.flex<br/>
yacc -J Parser.y<br/>
javac *.java<br/>
java Parser file<br/>

####Syntax of Ct Language
// Programa de teste da Linguagem CT

// Declaracao de Classes

classe Aluno {<br/>
	inteiro num, num_notas <br/>
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

classe Teste {

	funcao_principal {

		inteiro numero1
		inteiro numero2
		String nome

		numero1 <- 10
		numero2 <- 2 * (10 - 5 + (3 * (15-1)))

		nome <- "Marcos Defendi"
		numero1 <- nome.length
		nome <- nome.trim()

		se (numero1 > (numero2 * (numero1 / 2.0))){
			escrever("Entrou no if." + numero1 + "" + numero2)
		} senao {
			escrever("Entrou no else.")
		}

		_

	}
}

