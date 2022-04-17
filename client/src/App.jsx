import { ChakraProvider, theme } from '@chakra-ui/react';
import { Route, Routes } from 'react-router-dom';
import CreateProposal from './pages/CreateProposal';
import Home from './pages/Home';

function App() {
  return (
    <ChakraProvider theme={theme}>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/create-proposal" element={<CreateProposal />} />
      </Routes>
    </ChakraProvider>
  );
}

export default App;
