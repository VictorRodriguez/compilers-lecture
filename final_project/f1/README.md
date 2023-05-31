# Final project

Please create a compiler that reads human sentences and generate pandas queries
that search over the F1 files from https://www.kaggle.com/datasets/rohanrao/formula-1-world-championship-1950-2020

## Input of the query

The way you generate your query is up to you, you can choose and define the grammar
that you prefer it just has to be humanly readable and easy to understand, a good
example is:

```
Search all the results in results.csv with more than 10 points and less than 40 laps
```

or

```
Retrieve all the results that meet the specified criteria: more than 10 points and less than 40 laps
```
This will go in a file input.txt

Your team can decide how to define your grammar

Once you have your grammar please use YACC and LEX to generate a compiler that must generate the next 2 lines


```
./mycompiler input.txt

```
as a result it will print: 

```
import pandas as pd
df = pd.read_csv('results.csv')
print(df[(df['points'] > 10) & (df["laps"] <= 40)])
```

Where results.csv and the logic can change based on the sentence analyzed by your compiler


Have fun!


