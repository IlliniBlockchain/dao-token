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
      transition="all 0.3s"
      _hover={{ transform: 'translate3D(0,-1px,0) scale(1.03);' }}
    >
      {children}
    </Box>
  );
};

export default Card;
