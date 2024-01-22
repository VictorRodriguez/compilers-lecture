import pandas as pd

df = pd.read_csv('results.csv')
print(df[(df['points'] > 10) & (df["laps"] <= 40)])
