import { Box, Container } from '@chakra-ui/react';
import { ethers } from 'ethers';
import { useEffect, useState } from 'react';
import { Navbar } from '../components/NavBar';
import ProposalList from '../components/ProposalList';
import governorAbi from '../IlliniBlockchainGovernor.json';

  // import web3 from 'web3';


const Home = () => {
  const contractAddress = "0x2fbe59f807e728ed6b42e237e724296b542e5ba3"
  const [events, setEvents] = useState();

  useEffect(() => {
    async function getProposals() {
      const provider = new ethers.providers.AlchemyProvider("matic", process.env.REACT_APP_POLYGON); 
      const contract = new ethers.Contract(
        contractAddress,
        governorAbi,
        provider
      );
      const filter = contract.filters.ProposalCreated();
      const iface = new ethers.utils.Interface(governorAbi);
      const logs = await contract.queryFilter(filter);
      const parsedLogs = logs.map(log => iface.parseLog(log));
      setEvents(parsedLogs);
    } 
    getProposals()
    // eslint-disable-next-line
    }, [])

  return (
    <Box bgColor="white">
      <Navbar />
      <Container minW="50%">
        <ProposalList proposals={events} />
      </Container>
    </Box>
  );
};

export default Home;
