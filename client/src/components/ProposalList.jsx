import {
  Box,
  Button,
  Heading,
  HStack,
  Link,
  List,
  ListItem,
} from '@chakra-ui/react';

import { AddIcon } from '@chakra-ui/icons';
import { Proposal } from './Proposal';

const ProposalList = ({ proposals }) => {
  return (
    <Box>
      <HStack justify="space-between" alignContent="center" mb="25px">
        <Heading size="lg">Proposals</Heading>
        <Button
          as={Link}
          _hover={{ textDecoration: 'none' }}
          href="/create-proposal"
          size="sm"
          variant="outline"
          mr="-px"
          rightIcon={<AddIcon />}
        >
          Create Proposal
        </Button>
      </HStack>
      <List w="100%">
        {proposals.map(proposal => (
          <ListItem key={`${proposal.from}${proposal.name}`} mb="20px">
            <Proposal
              title={proposal.from}
              name={proposal.name}
              description={proposal.description}
            />
          </ListItem>
        ))}
      </List>
    </Box>
  );
};
export default ProposalList;
