import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import Header from './components/header';
import Search from './components/search.js';
import Weather from './components/weather.js';

function App() {
  console.log('App component rendered');
  return (
    <div>
      <h1>Welcome to the Weather App</h1>
      <p>This is the starting page.</p>
    </div>
  );
}

export default App;
