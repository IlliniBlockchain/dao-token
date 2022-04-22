import {
  Box,
  Button,
  Container,
  Flex,
  Heading,
  HStack,
  Icon,
  Link,
  Text,
  VStack,
  useMediaQuery,
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

  const sendVote = async (proposalId, support, option) => {
    setVotePending(true);
    option === 'A' ? setPressedOptionA(true) : setPressedOptionB(true);

    try {
      const governorContract = new ethers.Contract(
        governorAddress,
        governorAbi,
        provider
      );
      const contractWithSigner = governorContract.connect(signer);
      const tx = await contractWithSigner.castVote(
        '60884200414378236127785285185053811369384422552673398324665752021960087288477',
        support
      );
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
        description: 'You may have already voted on this proposal.',
        status: 'error',
        duration: 5000,
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
            <Heading>Proposal Name</Heading>
            <Heading size="md" as="h5" mt={6}>
              Description
            </Heading>
            <Text mt={4} lineHeight="1.75" fontSize="18px">
              Lorem ipsum dolor sit amet, consectetur adipiscing elit.
              Suspendisse elementum auctor porta. Cras consectetur aliquam diam
              eu scelerisque. Nunc ex felis, consectetur a varius et, vehicula
              id dui. Vivamus mollis libero et felis rutrum porta. Integer
              hendrerit lacus turpis, eget porttitor ipsum imperdiet vitae.
              Quisque ut tortor eget nulla maximus interdum a eu leo. Nam quis
              rutrum neque, in suscipit augue. Vivamus eu arcu quis odio dictum
              varius vel nec neque. Nullam nec velit nulla. Donec sed turpis et
              lectus suscipit fringilla. Ut sed purus quis sem sagittis euismod
              eget egestas est. In imperdiet pretium ex, a semper tortor ornare
              a. Morbi volutpat feugiat luctus. Praesent vestibulum mattis nisl
              eget pharetra. Vestibulum ante ipsum primis in faucibus orci
              luctus et ultrices posuere cubilia curae; Phasellus ut auctor
              ligula, id sagittis enim. In facilisis nibh sit amet pulvinar
              ultricies. Integer ultricies nunc id tellus eleifend, sed egestas
              erat ultricies. Maecenas laoreet sem in sem tempus, ut
              pellentesque neque tempor. Aenean ac odio dignissim, ultricies
              orci vulputate, pretium sapien. Sed consequat elementum libero eu
              gravida. In eu finibus mi. Curabitur et interdum justo. Etiam
              luctus ex diam, nec molestie purus dictum a. Proin at malesuada
              ipsum, id luctus purus. Nam vulputate volutpat justo sit amet
              semper. Duis non metus convallis, dignissim urna nec, condimentum
              turpis. Nullam faucibus orci eleifend tortor cursus, vitae
              eleifend lacus pretium. Etiam nibh est, ultrices nec maximus ac,
              dapibus at quam. Morbi vel luctus tellus. Proin sollicitudin elit
              pharetra molestie laoreet. Lorem ipsum dolor sit amet, consectetur
              adipiscing elit.
            </Text>
          </Box>
          <Box
            minW={useSmallerView ? '100%' : '300px'}
            maxW={useSmallerView ? '100%' : '315px'}
            margin="30px auto"
            h="fit-content"
            fontWeight="bold"
          >
            <Box border="2px solid grey" borderRadius="5px" p={4} mb={5}>
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
            </Box>
            <Box border="2px solid grey" borderRadius="5px" p={4}>
              <Heading as="h6" size="md" mb={5}>
                Cast your vote
              </Heading>
              <VStack w="100%">
                <Button
                  w="100%"
                  onClick={() => {
                    sendVote(0, 0, 'A');
                  }}
                  isLoading={pressedOptionA}
                  disabled={votePending}
                >
                  Option A
                </Button>
                <Button
                  w="100%"
                  isLoading={pressedOptionB}
                  disabled={votePending}
                  onClick={() => {
                    sendVote(0, 0, 'B');
                  }}
                >
                  Option B
                </Button>
              </VStack>
            </Box>
          </Box>
        </Flex>
      </Container>
    </Box>
  );
};

export default FullScreenProposal;
