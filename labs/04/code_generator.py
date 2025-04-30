import random

lines = [
    "// basic code\n",
    "//float b\n",
    "f b\n",
    "// integer a\n",
    "i a\n",
    "// a = 5\n",
    "a = 5\n",
    "// b = a + 3.2\n",
    "b = a + 3.2\n",
    "//print 8.5\n",
    "p b\n"
]

with open("example.ac", "w") as f:
    for line in lines:
        f.write(line)
