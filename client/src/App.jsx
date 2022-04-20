import { ChakraProvider } from '@chakra-ui/react';
import { Route, Routes } from 'react-router-dom';
import CreateProposal from './pages/CreateProposal';
import FullScreenProposal from './pages/FullScreenProposal';
import Home from './pages/Home';

function App() {
  return (
    <ChakraProvider>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/create-proposal" element={<CreateProposal />} />
        <Route path="/proposals/:title" element={<FullScreenProposal />} />
      </Routes>
    </ChakraProvider>
  );
}

export default App;
