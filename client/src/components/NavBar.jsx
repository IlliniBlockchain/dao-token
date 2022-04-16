import { Box, Container, Flex, HStack } from '@chakra-ui/react';
import { useState } from 'react';
import * as React from 'react';
import Wallet from '../Wallet';

export const Navbar = () => {
  const [connected, setConnected] = useState(false);
  const [walletAddress, setWalletAddress] = useState('');
  const [provider, setProvider] = useState(null);
  const [signer, setSigner] = useState(null);

  return (
    <Box as="section">
      <Box as="nav" bg="gray.50" boxShadow="md" mb="40px">
        <Container
          py={{
            base: '4',
            lg: '5',
          }}
          minWidth="90%"
        >
          {console.log(provider, signer)}
          <HStack spacing="10" justify="flex-end" w="100%">
            <Flex>
              <HStack spacing="3">
                <Wallet
                  connected={connected}
                  setConnected={setConnected}
                  walletAddress={walletAddress}
                  setWalletAddress={setWalletAddress}
                  setProvider={setProvider}
                  setSigner={setSigner}
                />
              </HStack>
            </Flex>
            )
          </HStack>
        </Container>
      </Box>
    </Box>
  );
};
