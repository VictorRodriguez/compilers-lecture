# CFG implemented in Lex and YACC


Lex and yacc help you write programs that transform structured input. This includes
an enormous range of applications—anything from a simple text search program that
looks for patterns in its input file to a C compiler that transforms a source program into
optimized object code.

One of those applications are the context-free grammars (CFG). CFG are a more
powerful method of describing languages. Such grammars can describe certain
features that have a recursive structure, which makes them useful in a variety
of applications.

## Activities

Create a program in LEX and YACC that analyise the CFG:

```
⟨SENTENCE⟩ → ⟨NOUN-PHRASE⟩⟨VERB-PHRASE⟩ ⟨NOUN-PHRASE⟩ → ⟨CMPLX-NOUN⟩ | ⟨CMPLX-NOUN⟩⟨PREP-PHRASE⟩
⟨VERB-PHRASE⟩ → ⟨CMPLX-VERB⟩ | ⟨CMPLX-VERB⟩⟨PREP-PHRASE⟩ ⟨PREP-PHRASE⟩ → ⟨PREP⟩⟨CMPLX-NOUN⟩
⟨CMPLX-NOUN⟩ → ⟨ARTICLE⟩⟨NOUN⟩ ⟨CMPLX-VERB⟩ → ⟨VERB⟩ | ⟨VERB⟩⟨NOUN-PHRASE⟩
⟨ARTICLE⟩ → a | the
⟨NOUN⟩ → boy | girl | flower
⟨VERB⟩ → touches | likes | sees ⟨PREP⟩ → with
```

Example of Input file :

a boy sees
the boy sees a flower
a girl with a flower likes the boy
a flower sees a flower

Each of these strings has a derivation in grammar

expected way to test yoru code:

```
./analyzer test.txt
PASS
PASS
PASS
FAIL
```

