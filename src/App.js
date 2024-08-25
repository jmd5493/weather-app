import React from 'react';
import Header from './components/header';
import Search from './components/search';
import WeatherDisplay from './components/weatherDisplay';
import './App.css';  // Global styles

function App() {
  return (
    <div className="App">
      <Header />
      <Search />
      <WeatherDisplay />
    </div>
  );
}

export default App;
