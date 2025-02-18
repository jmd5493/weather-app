import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './search.css';  // Ensure this path is correct

function Search() {
  const [city, setCity] = useState('');
  const navigate = useNavigate();

  const handleSubmit = (e) => {
    e.preventDefault();
    if (city) {
      navigate(`/weather/${city}`);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="form">
      <input
        type="text"
        value={city}
        onChange={(e) => setCity(e.target.value)}
        placeholder="Enter city"
        className="input"
      />
      <button type="submit" className="button">Search</button>
    </form>
  );
}

export default Search;