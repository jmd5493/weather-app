import React from 'react';
import './header.css';  // Import the corresponding CSS file

function Header() {
  console.log('Header rendered');
  return (
    <header className="app-header">
      <h1>Weather</h1>
    </header>
  );
}

export default Header;
