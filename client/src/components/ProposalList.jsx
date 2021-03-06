import {
  Box,
  Button,
  Center,
  Heading,
  HStack,
  Link,
  List,
  ListItem,
  Spinner,
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
      {proposals ? (
        <List w="100%">
          {proposals && proposals.map(proposal => (
            <ListItem key={proposal.args[0]} mb="20px">
              <Proposal title={proposal.args[0]._hex} name={proposal.args[8]} />
            </ListItem>
          ))}
        </List>
      ) : (
        <Center mt="50px">
          <Spinner />
        </Center>
      )}
    </Box>
  );
};
export default ProposalList;
