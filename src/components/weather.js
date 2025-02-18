import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';

function Weather() {
  const { city } = useParams();
  const [weather, setWeather] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchWeather = async () => {
      try {
        const response = await fetch(`http://api.weatherapi.com/v1/current.json?key=6477a696e4a14af4bfd222808242808&q=${city}`);
        if (!response.ok) {
          throw new Error('City not found');
        }
        const data = await response.json();
        setWeather(data);
      } catch (error) {
        setError(error.message);
      } finally {
        setLoading(false);
      }
    };

    fetchWeather();
  }, [city]);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>{error}</p>;

  return (
    <div>
      <h2>Weather in {city}</h2>
      <p>Temperature: {weather.current.temp_c}°C</p>
      <p>Weather: {weather.current.condition.text}</p>
    </div>
  );
}

export default Weather;