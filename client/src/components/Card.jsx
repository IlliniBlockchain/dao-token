import { Box, Link } from '@chakra-ui/react';
export const Card = ({ children, title }) => {
  return (
    <Box
      as={Link}
      display="block"
      _hover={{
        textDecoration: 'none',
        transform: 'translate3D(0,-1px,0) scale(1.03);',
        background: 'gray.50',
      }}
      href={`/proposals/${title}`}
      bg="white"
      w="100%"
      minH="150px"
      minW="300px"
      p="22px"
      borderRadius="15px"
      boxShadow="md"
      transition="all 0.3s"
    >
      {children}
    </Box>
  );
};

export default Card;
