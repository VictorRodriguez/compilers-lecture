# Actividad 3.2: Gramáticas Libres De Contexto | Lab 07
# Alumno: León Emiliano García Pérez [A00573074]
# Fecha de Entrega: Viernes 31 de Mayo de 2024

import requests

def get_weather(city):

    url = "http://api.weatherapi.com/v1/current.json"
    api_key = "dcd25a54cb474c27b4b35813243005"

    params = {
        'key': api_key,
        'q': city
    }

    response = requests.get(url, params=params)

    if response.status_code == 200:
        
        data = response.json()
        current = data['current']
        print(f"The current temperature at {city} is: {current['temp_c']} °C")

    else:
        print(f"Failed to get data for {city}. Check city name or API key!")
        print("Response:", response.json())

if __name__ == "__main__":

    city = "Zapopan"
    get_weather(city)