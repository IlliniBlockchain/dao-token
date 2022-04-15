import React from 'react';
import { ChakraProvider, Box, theme, Heading } from '@chakra-ui/react';

function App() {
  return (
    <ChakraProvider theme={theme}>
      <Box textAlign="center" fontSize="xl">
        <Heading>Hello Blockchainers</Heading>
      </Box>
    </ChakraProvider>
  );
}

export default App;
