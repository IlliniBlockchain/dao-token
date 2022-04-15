import {useState, useEffect} from 'react';
import { ChakraProvider, Box, theme, Heading, Button, Text } from '@chakra-ui/react';
import MetaMaskOnboarding from '@metamask/onboarding'
import { ethers, utils } from "ethers"
import Wallet from './Wallet'

function App() {

  const [ connected, setConnected ] = useState(false);
  const [ walletAddress, setWalletAddress ] = useState("");
  const [ provider, setProvider ] = useState(null);
  const [ signer, setSigner ] = useState(null);

  return (
    <ChakraProvider theme={theme}>
      <Box textAlign="center" fontSize="xl">
        <Heading>Hello Blockchainers</Heading>
      </Box>
      <Wallet connected={connected} setConnected={setConnected} walletAddress={walletAddress} setWalletAddress={setWalletAddress} setProvider={setProvider} setSigner={setSigner} />
    </ChakraProvider>
  );
}

export default App;
