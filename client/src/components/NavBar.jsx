import { Box, Container, HStack, Icon, Link } from '@chakra-ui/react';
import { useState } from 'react';
import * as React from 'react';
import Wallet from '../Wallet';
import { ReactComponent as IlliniBlockchainLogo } from '../assets/IlliniBlockchainLogo.svg';
export const Navbar = () => {
  const [connected, setConnected] = useState(false);
  const [walletAddress, setWalletAddress] = useState('');
  const [provider, setProvider] = useState(null);
  const [signer, setSigner] = useState(null);

  return (
    <Box as="section">
      <Box as="nav" bg="gray.50" boxShadow="md" mb="40px" height="80px">
        <Container
          py={{
            base: '4',
            lg: '5',
          }}
          minWidth="90%"
        >
          {console.log(provider, signer)}
          <HStack spacing="10" w="100%" justify="space-between">
            <Link href="/">
              <Icon as={IlliniBlockchainLogo} w="150px" h="50px" />
            </Link>
            <Wallet
              connected={connected}
              setConnected={setConnected}
              walletAddress={walletAddress}
              setWalletAddress={setWalletAddress}
              setProvider={setProvider}
              setSigner={setSigner}
            />
            )
          </HStack>
        </Container>
      </Box>
    </Box>
  );
};
