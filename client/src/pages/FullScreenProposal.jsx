import {
  Box,
  Container,
  Grid,
  GridItem,
  Heading,
  HStack,
  Text,
  useBreakpoint,
  VStack,
} from '@chakra-ui/react';
import { Navbar } from '../components/NavBar';

export const FullScreenProposal = () => {
  const colCount = useBreakpoint({ base: 7, sm: 4, md: 4 });
  console.log(colCount);

  return (
    <Box bg="gray.50">
      <Navbar />
      <Container minW="90%">
        <Grid
          templateColumns={`repeat(${
            colCount === 'md' || colCount === 'sm' || colCount === 'base'
              ? 4
              : 7
          }, 1fr)`}
          h="100vh"
          gap="50px"
        >
          <GridItem rowSpan={2} colSpan={6}>
            <Heading>Proposal Name</Heading>

            <Heading as="h6" size="sm" mt={6}>
              Description
            </Heading>
            <Text mt={4}>
              Lorem ipsum dolor sit amet, consectetur adipiscing elit.
              Suspendisse elementum auctor porta. Cras consectetur aliquam diam
              eu scelerisque. Nunc ex felis, consectetur a varius et, vehicula
              id dui. Vivamus mollis libero et felis rutrum porta. Integer
              hendrerit lacus turpis, eget porttitor ipsum imperdiet vitae.
              Quisque ut tortor eget nulla maximus interdum a eu leo. Nam quis
              rutrum neque, in suscipit augue. Vivamus eu arcu quis odio dictum
              varius vel nec neque. Nullam nec velit nulla. Donec sed turpis et
              lectus suscipit fringilla. Ut sed purus quis sem sagittis euismod
              eget egestas est. In imperdiet pretium ex, a semper tortor ornare
              a. Morbi volutpat feugiat luctus. Praesent vestibulum mattis nisl
              eget pharetra. Vestibulum ante ipsum primis in faucibus orci
              luctus et ultrices posuere cubilia curae; Phasellus ut auctor
              ligula, id sagittis enim. In facilisis nibh sit amet pulvinar
              ultricies. Integer ultricies nunc id tellus eleifend, sed egestas
              erat ultricies. Maecenas laoreet sem in sem tempus, ut
              pellentesque neque tempor. Aenean ac odio dignissim, ultricies
              orci vulputate, pretium sapien. Sed consequat elementum libero eu
              gravida. In eu finibus mi. Curabitur et interdum justo. Etiam
              luctus ex diam, nec molestie purus dictum a. Proin at malesuada
              ipsum, id luctus purus. Nam vulputate volutpat justo sit amet
              semper. Duis non metus convallis, dignissim urna nec, condimentum
              turpis. Nullam faucibus orci eleifend tortor cursus, vitae
              eleifend lacus pretium. Etiam nibh est, ultrices nec maximus ac,
              dapibus at quam. Morbi vel luctus tellus. Proin sollicitudin elit
              pharetra molestie laoreet. Lorem ipsum dolor sit amet, consectetur
              adipiscing elit.
            </Text>
          </GridItem>
          <GridItem
            rowSpan={2}
            colSpan={
              colCount === 'md' || colCount === 'sm' || colCount === 'base'
                ? 6
                : 1
            }
            minW="300px"
          >
            <VStack
              w="100%"
              fontWeight="bold"
              mt={10}
              justify="flex-start"
              border="1px solid grey"
              borderRadius="5px"
              p={4}
            >
              <Heading
                w="100%"
                textAlign="center"
                as="h6"
                size="md"
                mb={5}
                borderBottom="1px solid grey"
              >
                Information
              </Heading>
              <HStack w="100%" justify="space-between">
                <Text>Author</Text>
                <Text>0x1</Text>
              </HStack>
              <HStack w="100%" justify="space-between">
                <Text w="100%">Start Date</Text>
                <Text>Apr 8, 2022, 7:36 AM</Text>
              </HStack>
              <HStack w="100%" justify="space-between">
                <Text w="100%">End Date</Text>
                <Text>Apr 15, 2022, 8:00 AM</Text>
              </HStack>
            </VStack>
          </GridItem>
        </Grid>
      </Container>
    </Box>
  );
};

export default FullScreenProposal;
