import {
  Box,
  Button,
  Container,
  Flex,
  Heading,
  Icon,
  Link,
  Text,
  VStack,
  useMediaQuery,
  Tooltip,
} from '@chakra-ui/react';
import { BsArrowLeft } from 'react-icons/bs';
import { Navbar } from '../components/NavBar';
import { useState } from 'react';
import governorAbi from '../IlliniBlockchainGovernor.json';
import { ethers } from 'ethers';
import { useToast } from '@chakra-ui/react';

const governorAddress = '0x6Ee1c790db9439366141a19Cee7fa51A15f2Af39';

export const FullScreenProposal = () => {
  const [useSmallerView] = useMediaQuery('(max-width: 1200px)');
  const toast = useToast();
  const [votePending, setVotePending] = useState(false);
  const [connected, setConnected] = useState(false);
  const [walletAddress, setWalletAddress] = useState('');
  const [provider, setProvider] = useState(null);
  const [signer, setSigner] = useState(null);
  const [pressedOptionA, setPressedOptionA] = useState(false);
  const [pressedOptionB, setPressedOptionB] = useState(false);

  const sendVote = async (support, option) => {
    setVotePending(true);
    option === 'A' ? setPressedOptionA(true) : setPressedOptionB(true);
    const url = window.location.href;
    const id = url.split('/')[4];
    try {
      const governorContract = new ethers.Contract(
        governorAddress,
        governorAbi,
        provider
      );
      const contractWithSigner = governorContract.connect(signer);
      const tx = await contractWithSigner.castVote(id, support);
      await tx.wait();

      toast({
        title: 'Successfully casted vote',
        status: 'success',
        duration: 5000,
        position: 'top',
        isClosable: true,
      });
    } catch {
      toast({
        title: 'Error casting vote',
        description:
          'Make sure your wallet is connected and you have not already voted on this proposal.',
        status: 'error',
        duration: 7000,
        position: 'top',
        isClosable: true,
      });
    }
    setPressedOptionA(false);
    setPressedOptionB(false);
    setVotePending(false);
  };

  return (
    <Box bg="white">
      <Navbar
        connected={connected}
        setConnected={setConnected}
        walletAddress={walletAddress}
        setWalletAddress={setWalletAddress}
        setProvider={setProvider}
        setSigner={setSigner}
      />
      <Container minW="80%" pb="100px">
        <Flex flexDir={useSmallerView ? 'column' : 'row'}>
          <Box margin="0 auto" mr={useSmallerView ? '0' : '50px'} maxW="800px">
            <Button
              as={Link}
              href="/"
              _hover={{ textDecoration: 'none' }}
              p="0px"
              variant="no-hover"
              bg="transparent"
            >
              <Icon
                as={BsArrowLeft}
                w="20px"
                h="20px"
                fontSize="2xl"
                transition="all .5s ease"
                cursor="pointer"
                pt="4px"
              />
              <Text
                fontSize="sm"
                color={'gray.700'}
                fontWeight="bold"
                cursor="pointer"
                ml="5px"
              >
                Back
              </Text>
            </Button>
            <Heading>Minority Game</Heading>
            <Heading size="md" as="h5" mt={6}>
              Description
            </Heading>
            <Text mt={4} lineHeight="1.75" fontSize="18px">
              The minority game is a game where the minority vote wins the game.
              If Option B has fewer votes than Option A, then Option B Voters
              get equal splits of the prize. The prize pool $50, so get your
              votes in!
            </Text>
          </Box>
          <Box
            minW={useSmallerView ? '100%' : '300px'}
            maxW={useSmallerView ? '100%' : '315px'}
            margin="30px auto"
            h="fit-content"
            fontWeight="bold"
          >
            {/* <Box border="2px solid grey" borderRadius="5px" p={4} mb={5}>
              <Heading as="h6" size="md" mb={5}>
                Information
              </Heading>
              <HStack mb="8px" justify="space-between">
                <Text color="gray.500">Author</Text>
                <Text noOfLines="1">0x12345678901234567890</Text>
              </HStack>
              <HStack mb="8px" justify="space-between">
                <Text color="gray.500">Start Date</Text>
                <Text>Apr 8, 2022, 7:36 AM</Text>
              </HStack>
              <HStack mb="8px" justify="space-between">
                <Text color="gray.500">End Date</Text>
                <Text>Apr 15, 2022, 8:00 AM</Text>
              </HStack>
            </Box> */}
            <Box border="2px solid grey" borderRadius="5px" p={4}>
              <Heading as="h6" size="md" mb={5}>
                Cast your vote
                <Tooltip label="Make sure your wallet is connected and you have not already voted on this proposal.">
                  <Icon ml="10px" />
                </Tooltip>
              </Heading>
              <VStack w="100%">
                {connected ? (
                  <Button
                    w="100%"
                    onClick={() => {
                      sendVote(0, 'A');
                    }}
                    isLoading={pressedOptionA}
                    disabled={votePending}
                  >
                    Option A
                  </Button>
                ) : (
                  <Tooltip hasArrow label="Search places">
                    <Button
                      w="100%"
                      onClick={() => {
                        sendVote(0, 'A');
                      }}
                      isLoading={pressedOptionA}
                      disabled
                    >
                      Option A
                    </Button>
                  </Tooltip>
                )}
                {connected ? (
                  <Button
                    w="100%"
                    isLoading={pressedOptionB}
                    disabled={votePending || !connected}
                    onClick={() => {
                      sendVote(0, 0, 'B');
                    }}
                  >
                    Option B
                  </Button>
                ) : (
                  <Tooltip hasArrow label="Search places">
                    <Button
                      w="100%"
                      isLoading={pressedOptionB}
                      disabled
                      onClick={() => {
                        sendVote(0, 0, 'B');
                      }}
                    >
                      Option B
                    </Button>
                  </Tooltip>
                )}
              </VStack>
            </Box>
          </Box>
        </Flex>
      </Container>
    </Box>
  );
};

export default FullScreenProposal;
