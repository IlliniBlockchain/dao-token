import {useState, useEffect} from 'react';
import { ChakraProvider, Box, theme, Heading, Button, Text } from '@chakra-ui/react';
import MetaMaskOnboarding from '@metamask/onboarding'
import { ethers, utils } from "ethers"

function Wallet({ connected, setConnected, walletAddress, setWalletAddress, setProvider, setSigner }) {

    const [ pendingConnect, setPendingConnect ] = useState(false);
    const [ metaMaskInstalled, setMetaMaskInstalled ] = useState(false);

    const isMetaMaskInstalled = () => {
        const { ethereum } = window;
        return Boolean(ethereum && ethereum.isMetaMask);
      };
    
      const onClickInstall = () => {
        const onboarding = new MetaMaskOnboarding({ });
        onboarding.startOnboarding();
      };
    
      const onClickConnect = async () => {
        try {
          setPendingConnect(true);

          const providerTemp = new ethers.providers.Web3Provider(window.ethereum);
          // actual code to connect wallet
          const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
    
          setProvider(providerTemp);
          const signerTemp = providerTemp.getSigner();
          setSigner(signerTemp);
          const account = await signerTemp.getAddress();
          setWalletAddress(account);

          setConnected(true);
          setPendingConnect(false);
    
        } catch (error) {
          console.error(error);
        }
      };
    
      useEffect(() => {
        setMetaMaskInstalled(isMetaMaskInstalled());
      }, []);
    
    return (
        <Box>
        {
            connected
            ?
            <Text>{walletAddress.slice(0, 10) + "..."}</Text>
            :
            <Button colorScheme='blue' onClick={(metaMaskInstalled ? onClickConnect : onClickInstall)}>
            {
                metaMaskInstalled
                ?
                (pendingConnect ? "Pending" : "Connect wallet")
                :
                "Install MetaMask"
            }
            </Button>
        }
        </Box>
    )

}

export default Wallet;