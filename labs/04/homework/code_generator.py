

def studentInformation():
    print('Miguel Angel Cabrera Victoria')
    print('A01782982')
    print('age = 20')
    print('// This is a comment')

def teacherInformation():
    print('Victor Rodriguez')
    print('role = teacher')

def numbers():
    for i in range(21):
        print(i)

def zeroToOne():
    for i in range(10):
        print(f'0.{i}')

def main():
    studentInformation()
    numbers()
    zeroToOne()
    teacherInformation()


if __name__ == '__main__':
    main()
