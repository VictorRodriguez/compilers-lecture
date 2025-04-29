import string
import random
import argparse

def id_generator(size=10, chars=string.ascii_uppercase + string.digits):
    return ''.join(random.choice(chars) for _ in range(size))

opreators = ["+","-","*","/"]

def get_comment_line():
    comment_line = "//%s" % (id_generator())
    return comment_line

def get_float_line():
    float_line = "f %s" % (random.choice(string.ascii_lowercase))
    return float_line

def get_integer_line():
    integer_line = "i %s"% (random.choice(string.ascii_lowercase))
    return integer_line

def get_asigment_line():
    asigment_line = "%s = %s" %(random.choice(string.ascii_lowercase),\
        random.randint(0,100))
    return asigment_line

def get_asigment_line_2():
    asigment_line_2 = "%s = %s %s %s" % \
            (random.choice(string.ascii_lowercase),\
            random.choice(string.ascii_lowercase),\
            random.choice(opreators),\
            random.randint(0,100))
    return asigment_line_2

def get_print_line():
    print_line = "p %s" % (random.choice(string.ascii_lowercase))
    return print_line


parser = argparse.ArgumentParser(description='Generate random AC code')
parser.add_argument('--stress', dest='stress', action='store_true',\
        help='generate HUGE code to stress the lab')
args = parser.parse_args()

if args.stress:
    f= open("random_code.ac","w+")
    for x in range(0, 100000):
        comment_line = get_comment_line()
        float_line = get_float_line()
        integer_line = get_integer_line()
        asigment_line = get_asigment_line()
        asigment_line_2 = get_asigment_line_2()
        print_line = get_print_line()

        f.write(comment_line + "\n")
        f.write(float_line + "\n")
        f.write(integer_line + "\n")
        f.write(asigment_line+ "\n")
        f.write(asigment_line_2 + "\n")
        f.write(print_line + "\n")

    f.close()

else:
    comment_line = get_comment_line()
    float_line = get_float_line()
    integer_line = get_integer_line()
    asigment_line = get_asigment_line()
    asigment_line_2 = get_asigment_line_2()
    print_line = get_print_line()

    print(comment_line)
    print(float_line)
    print(integer_line)
    print(asigment_line)
    print(asigment_line_2)
    print(print_line)

