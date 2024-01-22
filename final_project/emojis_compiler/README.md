# Emoji to Natural language compiler


## Introduction

The days of English as a global language may be coming to an end—it might be
replaced in the near future by icons of smiley faces, cats and hearts. While
more than 1.5 billion people speak English, 3.2 billion use the Internet, three
quarters of them through smartphones equipped with emojis.

More than 90% of social networking users communicate through these symbols and
more than 6 billion emojis are exchanged every day. This kind of message has
become so common that the Oxford Dictionary named the “Face with Tears of Joy”
emoji the Word of the Year 2015.

Because of this the importance of a language compiler from Emoji langue to
natural language might be necesary in the incoming world.

## Goal

* Do a research of the [state of the art] for natural language processing of emoji
* Create basic gramar for simple known sentences
* Design lexical/syntax/semantic analyser
* Implement in Lex and YACCT.

## Design and expected input/output

Example of input:

```
:wave: how are :arrow_right::bust_in_silhouette:?
```

Should be translated to:
```
hi how are you?
```
or

This is 🦋 🆒! I ❌️ ⏳️ 👀 what this thing 🥫 do!

Should be translated to:
```
This is pretty cool! I can't wait to see what this thing can do!
```

Take as help the page:

https://emojitranslate.com/

Other examples of inputs could be:

* Hmm this is a rather interesting little app.
* It's really sad that not enough puppies are adopted every year.
* This thing totally sucks! Who's idea was this anyways?!

## Report and presentation

Presentation should be done in front of the team with a writen report made in
latex using this
[template](https://github.com/VictorRodriguez/operating-systems-lecture/blob/master/projects/report.tex)

Teams have to deliver:

	* Printed report
	* Printed LateX code
	* Send presentation to profesor

Resources:
	* https://www.bbc.com/future/article/20151012-will-emoji-become-a-new-language


[state of the art](https://www.bbc.com/future/article/20151012-will-emoji-become-a-new-language)
