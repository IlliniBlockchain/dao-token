import { useState, useEffect } from 'react';
import { Box, Button, Text } from '@chakra-ui/react';
import MetaMaskOnboarding from '@metamask/onboarding';
import { ethers } from 'ethers';

function Wallet({
  connected,
  setConnected,
  walletAddress,
  setWalletAddress,
  setProvider,
  setSigner,
}) {
  const [pendingConnect, setPendingConnect] = useState(false);
  const [metaMaskInstalled, setMetaMaskInstalled] = useState(false);

  const isMetaMaskInstalled = () => {
    const { ethereum } = window;
    return Boolean(ethereum && ethereum.isMetaMask);
  };

  const onClickInstall = () => {
    const onboarding = new MetaMaskOnboarding({});
    onboarding.startOnboarding();
  };

  const onClickConnect = async () => {
    try {
      setPendingConnect(true);
      await window.ethereum.request({
        method: 'eth_requestAccounts',
      });
      const providerTemp = new ethers.providers.Web3Provider(window.ethereum);
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
      {connected ? (
        <Text isTruncated maxWidth="150px" color="black">
          {walletAddress}
        </Text>
      ) : (
        <Button
          variant="solid"
          colorScheme="blue"
          onClick={metaMaskInstalled ? onClickConnect : onClickInstall}
        >
          {metaMaskInstalled
            ? pendingConnect
              ? 'Pending'
              : 'Connect wallet'
            : 'Install MetaMask'}
        </Button>
      )}
    </Box>
  );
}

export default Wallet;
