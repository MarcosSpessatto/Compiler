# Transpiler from CT language to Java

**run**
jflex LexicalAnalyzer.flex
yacc -J Parser.y
javac *.java
java Parser file
