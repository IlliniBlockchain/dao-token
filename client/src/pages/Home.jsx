import { Box, Container } from '@chakra-ui/react';
import { useEffect, useState } from 'react';
import { Navbar } from '../components/NavBar';
import ProposalList from '../components/ProposalList';
import { getEvents } from '../utils/api';

// import web3 from 'web3';

const Home = () => {

  const [ events, setEvents] = useState();

  useEffect(() => {
    async function getProposals() {
      const data = await getEvents("0x6ee1c790db9439366141a19cee7fa51a15f2af39", "0x7d84a6263ae0d98d3329bd7b46bb4e8d6f98cd35a7adb45c274c8b7fd5ebd5e0");
      setEvents(data)
    }
    getProposals()
    // const test = web3.eth.abi.decodeParameters(["uint256", "address", "address[]", "uint256[]", "string[]", "bytes[]", "uint256", "uint256", "string"],
                                // events[0])
    console.log(test)
  }, [])

  return (
    <Box bgColor="gray.50">
      <Navbar />
      <Container minW="50%">
        <ProposalList proposals={mockProposalData} />
      </Container>
    </Box>
  );
};

export default Home;

const mockProposalData = [
  {
    from: '0x1',
    name: 'Proposal 1',
    description: 'Description 1',
  },
  {
    from: '0x2',
    name: 'Proposal 2',
    description: 'Description 2',
  },
  {
    from: '0x3',
    name: 'Proposal 3',
    description: 'Description 3',
  },
  {
    from: '0x4',
    name: 'Proposal 4',
    description: 'Description 4',
  },
  {
    from: '0x5',
    name: 'Proposal 5',
    description: 'Description 5',
  },
  {
    from: '0x6',
    name: 'Proposal 6',
    description: 'Description 6',
  },
  {
    from: '0x7',
    name: 'Proposal 7',
    description: 'Description 7',
  },
  {
    from: '0x8',
    name: 'Proposal 8',
    description: 'Description 8',
  },
  {
    from: '0x9',
    name: 'Proposal 9',
    description: 'Description 9',
  },
  {
    from: '0x10',
    name: 'Proposal 10',
    description: 'Description 10',
  },
  {
    from: '0x11',
    name: 'Proposal 11',
    description: 'Description 11',
  },
  {
    from: '0x12',
    name: 'Proposal 12',
    description: 'Description 12',
  },
  {
    from: '0x13',
    name: 'Proposal 13',
    description: 'Description 13',
  },
  {
    from: '0x14',
    name: 'Proposal 14',
    description: 'Description 14',
  },
  {
    from: '0x15',
    name: 'Proposal 15',
    description: 'Description 15',
  },
  {
    from: '0x16',
    name: 'Proposal 16',
    description: 'Description 16',
  },
  {
    from: '0x17',
    name: 'Proposal 17',
    description: 'Description 17',
  },
  {
    from: '0x18',
    name: 'Proposal 18',
    description: 'Description 18',
  },
  {
    from: '0x19',
    name: 'Proposal 19',
    description: 'Description 19',
  },
  {
    from: '0x20',
    name: 'Proposal 20',
    description: 'Description 20',
  },
];
