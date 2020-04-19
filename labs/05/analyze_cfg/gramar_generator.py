import string
import random
import argparse


# example of gramar in BNF form
# <expr> ::= <term> "+" <expr>
#         |  <term>
# <term> ::= <factor> "*" <term>
#         |  <factor>
# <factor> ::= "(" <expr> ")"
#           |  <const>
# <const> ::= integer

def id_generator(size=10, chars=string.ascii_uppercase + string.digits):
    return ''.join(random.choice(chars) for _ in range(size))

operators = ["|",""]

def get_expresions(start):
    none_term,first_section,operand,second_section = get_statements()
    if start:
        S = "<S> ::= <%s> | <%s>" % (first_section,second_section)
    else:
        sections = [first_section,second_section]
        S = "<%s> ::= <%s> %s <%s>" % (random.choice(sections),\
        random.choice(string.ascii_lowercase),\
        operand,\
        random.choice(string.ascii_lowercase))
    return S

def get_terminals():
    terminal = "<%s> ::= %s" % (random.choice(string.ascii_lowercase),\
    random.choice(string.ascii_lowercase))
    return(terminal)


def get_statements():

    none_term = random.choice(string.ascii_lowercase)
    first_section = random.choice(string.ascii_lowercase)
    operand = random.choice(operators)
    second_section = random.choice(string.ascii_lowercase)
    return none_term,first_section,operand,second_section

start = True
print(get_expresions(start))

start = False
for i in range(10):
    print(get_expresions(start))
    print(get_terminals())
