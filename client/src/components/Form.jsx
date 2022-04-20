import {
  FormControl,
  FormLabel,
  Input,
  Textarea,
  Button,
  SimpleGrid,
} from '@chakra-ui/react';

const Form = () => {
  return (
    <SimpleGrid>
      <FormControl isRequired>
        <FormLabel mt="20px">Title</FormLabel>
        <Input />
      </FormControl>
      <FormControl>
        <FormLabel mt="20px">Description (optional)</FormLabel>
        <Textarea
          height="300px"
          placeholder="Enter more details about your proposal"
        />
      </FormControl>

      <Button mt="50px" colorScheme="green">
        Submit
      </Button>
    </SimpleGrid>
  );
};

export default Form;
