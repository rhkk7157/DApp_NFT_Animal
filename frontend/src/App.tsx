import React, { FC } from 'react';
import { Button } from '@chakra-ui/react';
import { BrowserRouter, Route, Routes } from 'react-router-dom';
import Main from './routes/Main';

const App: FC = () => {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Main />}></Route>
      </Routes>
    </BrowserRouter>
  );
};

export default App;
