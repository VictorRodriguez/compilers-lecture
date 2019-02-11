import string
import random

def id_generator(size=10, chars=string.ascii_uppercase + string.digits):
    return ''.join(random.choice(chars) for _ in range(size))

opreators = ["+","-","*","/"]
comment_line = "//%s" % (id_generator())
float_line = "f %s" % (random.choice(string.ascii_lowercase))
integer_line = "i %s"% (random.choice(string.ascii_lowercase))
asigment_line = "%s = %s" %(random.choice(string.ascii_lowercase),\
        random.randint(0,100))
asigment_line_2 = "%s = %s %s %s" % \
        (random.choice(string.ascii_lowercase),\
        random.choice(string.ascii_lowercase),\
        random.choice(opreators),\
        random.randint(0,100))
print_line = "p %s" % (random.choice(string.ascii_lowercase))

print(comment_line)
print(float_line)
print(integer_line)
print(asigment_line)
print(asigment_line_2)
print(print_line)

