import { Box } from '@chakra-ui/react';
export const Card = ({ children }) => {
  return (
    <Box
      bg="white"
      w="100%"
      minW="300px"
      p="22px"
      borderRadius="15px"
      boxShadow="md"
    >
      {children}
    </Box>
  );
};

export default Card;
