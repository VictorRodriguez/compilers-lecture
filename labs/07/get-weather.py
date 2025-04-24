# get_weather.py
import requests
import json

def get_ip_address():
    response = requests.get('https://api.ipify.org?format=json')
    ip_data = response.json()
    return ip_data['ip']

def get_location(ip_address):
    response = requests.get(f'http://ip-api.com/json/{ip_address}')
    location_data = response.json()
    return location_data['city'], location_data['country']

def get_weather(city, country):
    api_key = "26a1514c72f159d292e169a466f73222"  # Replace with your actual OpenWeatherMap API key
    url = f'http://api.openweathermap.org/data/2.5/weather?q={city},{country}&appid={api_key}'
    response = requests.get(url)
    weather_data = response.json()
    return weather_data['weather'][0]['description']

def main():
    ip_address = get_ip_address()
    city, country = get_location(ip_address)
    weather_description = get_weather(city, country)
    print(f"Chatbot: The weather in {city}, {country} is {weather_description}.")

if __name__ == "__main__":
    main()
