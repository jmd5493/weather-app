import React from 'react';
import './weatherDisplay.css';  // Import the corresponding CSS file

function WeatherDisplay({ weatherData }) {
  if (!weatherData) {
    return <div className="weather-display">No data available</div>;
  }

  return (
    <div className="weather-display">
      <h2>{weatherData.city}</h2>
      <p>Temperature: {weatherData.temperature}°C</p>
      <p>Humidity: {weatherData.humidity}%</p>
      <p>Condition: {weatherData.condition}</p>
    </div>
  );
}

export default WeatherDisplay;
