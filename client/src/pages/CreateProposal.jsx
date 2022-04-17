import {
  Alert,
  AlertIcon,
  Box,
  Button,
  Container,
  Icon,
  Link,
  Text,
} from '@chakra-ui/react';
import Form from '../components/Form';
import { Navbar } from '../components/NavBar';
import { BsArrowLeft } from 'react-icons/bs';

const CreateProposal = () => {
  return (
    <Box>
      <Navbar />
      <Container h="100vh - 80px">
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
        <Alert status="info" borderRadius="5px">
          <AlertIcon />
          Your wallet must contain an Illini Blockchain DAO Token in order to
          submit a proposal
        </Alert>

        <Form />
      </Container>
    </Box>
  );
};

export default CreateProposal;
