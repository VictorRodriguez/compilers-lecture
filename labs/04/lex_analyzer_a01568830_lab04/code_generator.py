import random

variables = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']

code = "// basic code\n"

code += "f {}\n".format(random.choice(variables))

code += "i {}\n".format(random.choice(variables))

code += "{} = {}\n".format(random.choice(variables), random.randint(0, 100))

code += "{} = {} + {}\n".format(random.choice(variables), random.choice(variables), round(random.uniform(0, 100), 5))

code += "p {}\n".format(random.choice(variables))

print(code)

