# Lea YACB (yet another chatbot)

```plaintext
  .---.       .-''-.     ____                .--.  ____     __   ____        _______    _______   .--.     
  | ,_|     .'_ _   \  .'  __ `.            / ,-'  \   \   /  /.'  __ `.    /   __  \  \  ____  \ `-. \    
,-./  )    / ( ` )   '/   '  \  \          /_/      \  _. /  '/   '  \  \  | ,_/  \__) | |    \ |    \_\   
\  '_ '`) . (_ o _)  ||___|  /  |         _( )_      _( )_ .' |___|  /  |,-./  )       | |____/ /   _( )_  
 > (_)  ) |  (_,_)___|   _.-`   |        (_ o _) ___(_ o _)'     _.-`   |\  '_ '`)     |   _ _ '.  (_ o _) 
(  .  .-' '  \   .---..'   _    |         (_,_) |   |(_,_)'   .'   _    | > (_)  )  __ |  ( ' )  \  (_,_)  
 `-'`-'|___\  `-'    /|  _( )_  |          \ \  |   `-'  /    |  _( )_  |(  .  .-'_/  )| (_{;}_) |   / /   
  |        \\       / \ (_ o _) /           \ `-.\      /     \ (_ o _) / `-'`-'     / |  (_,_)  /.-' /    
  `--------` `'-..-'   '.(_,_).'             `--' `-..-'       '.(_,_).'    `._____.'  /_______.' `--'     
```

**Meet Lea (YACB)!**

Lea is yet another chatbot that can help with all sorts of queries. Want to know the time? Need a weather update? Looking for a good joke or some music recommendations? Give it a try!

## What can Lea do?

### Greetings, Farewells, and Thank Yous

Say hello, goodbye, or thank you to Lea!

### Queries: Time, Weather, Names, Jokes

Ask Lea questions like:

- what time is it
- how is the weather
- tell me a joke
- what is your name

### Math Operations

Lea is super smart! Try some basic operations (+, -, *, /) like:

- `5 + 5 * 2`
- `(8 - 4) * (10 / 5)`

### Sing a Song

Lea can also sing, just ask:

- sing a song
- sing a part of a cool song

### Music Recommendations

Lea can help you with music recommendations too!

- For albums: recommend me an album
- For artists: recommend me an artist
- For songs: recommend me a song

## Instructions

### Step 1: Install `lex` and `yacc`

Make sure you have `flex`, `bison`, `gcc` and `sqlite3` installed on your machine.

### Step 2: Get the Files

Next, you need the chatbot files (`chatbot.l` and `chatbot.y`). You can either copy and paste them from this folder or clone this repository.

### Step 3: Open the Terminal and Compile

Open your terminal and run the following commands to compile the `lex` (.l) and `yacc` (.y) files.

```console
flex chatbot.l
bison -d chatbot.y
gcc lex.yy.c chatbot.tab.c -o chatbot -lsqlite3
```

> **_NOTE:_** When you run `flex chatbot.l`, it will generate a `lex.yy.c` file. And, `bison -d chatbot.y` will generate two files, `chatbot.tab.c` and `chatbot.tab.h`.

### Step 4: Run the Chatbot

Run this command to start Lea:

```console
./chatbot
```

### Step 5: Test the Chatbot

Lea is ready to chat! Go ahead and test it with some queries.
