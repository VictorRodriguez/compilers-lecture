import random

# List of strings
choices = ["""
// basic code
//float b
f b 
// integer a
i a
// a = 5
a = 5
// b = a + 3.2
b = a + 3.2
//print 8.5'
p b""",
"""
// Hello everyone
//
f z 
// How are you?
i x
// Me good thank you
x = 5
// Sayonara
z = x + 3.2
// I am a comment
p z"""]

# Print a random sample from the list
print(random.choice(choices))

