import { Box, Container, HStack, Icon, Link } from '@chakra-ui/react';
import * as React from 'react';
import Wallet from '../Wallet';
import { ReactComponent as IlliniBlockchainLogoDark } from '../assets/IlliniBlockchainLogoDark.svg';
export const Navbar = ({
  connected,
  setConnected,
  walletAddress,
  setWalletAddress,
  provider,
  setProvider,
  signer,
  setSigner,
  home,
}) => {
  return (
    <Box
      as="section"
      top="0"
      position="sticky"
      boxShadow="lg"
      bg="white"
      zIndex="docked"
    >
      <Box as="nav" mb="40px" height="80px">
        <Container height="80px" minWidth="90%">
          {console.log(provider, signer)}
          <HStack height="80px" spacing="10" w="100%" justify="space-between">
            <Link href="/">
              <Icon as={IlliniBlockchainLogoDark} w="150px" h="50px" />
            </Link>
            {
              home
              ?
              <></>
              :
              <Wallet
                connected={connected}
                setConnected={setConnected}
                walletAddress={walletAddress}
                setWalletAddress={setWalletAddress}
                setProvider={setProvider}
                setSigner={setSigner}
              />
            }
            )
          </HStack>
        </Container>
      </Box>
    </Box>
  );
};
