import { Box, Container } from '@chakra-ui/react';
import { ethers } from 'ethers';
import { useEffect, useState } from 'react';
import { Navbar } from '../components/NavBar';
import ProposalList from '../components/ProposalList';
import governorAbi from '../IlliniBlockchainGovernor.json'

  // import web3 from 'web3';


const Home = () => {
  const contractAddress = "0x6ee1c790db9439366141a19cee7fa51a15f2af39"
  const [events, setEvents] = useState();
  const provider = ethers.getDefaultProvider('rinkeby')

  useEffect(() => {
    async function getProposals() { 

      const contract = new ethers.Contract(contractAddress, governorAbi, provider)
      const filter = contract.filters.ProposalCreated();
      const iface = new ethers.utils.Interface(governorAbi);
      const logs = await contract.queryFilter(filter);
      const parsedLogs = logs.map((log) => iface.parseLog(log));      
      setEvents(parsedLogs)
    }
    getProposals()
    // eslint-disable-next-line
    }, [])

  return (
    <Box bgColor="gray.50">
      <Navbar />
      <Container minW="50%">
        <ProposalList proposals={events} />
      </Container>
    </Box>
  );
};

export default Home;
