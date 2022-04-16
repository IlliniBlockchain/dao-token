import { ChakraProvider, theme } from '@chakra-ui/react';
// import MetaMaskOnboarding from '@metamask/onboarding'
// import { ethers, utils } from "ethers"

import Home from './components/Home';

function App() {
  return (
    <ChakraProvider theme={theme}>
      <Home />
    </ChakraProvider>
  );
}

export default App;
