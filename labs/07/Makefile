# Actividad 3.2: Gramáticas Libres De Contexto | Lab 07
# Alumno: León Emiliano García Pérez [A00573074]
# Fecha de Entrega: Viernes 31 de Mayo de 2024

all:
        yacc -d chatbot.y
        lex chatbot.l
        gcc y.tab.c lex.yy.c -o chatbot

clean:
        rm -rf chatbot
        rm -rf lex.yy.c
        rm -rf y.tab.c
        rm -rf y.tab.h
        rm -rf y.tab.h.gch