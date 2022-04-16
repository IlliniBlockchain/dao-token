// Chakra imports
import {
  Box,
  Button,
  Flex,
  Icon,
  Spacer,
  Text,
  useColorModeValue,
} from '@chakra-ui/react';
// Custom components

import React from 'react';
// react icons
import { BsArrowRight } from 'react-icons/bs';
import Card from './Card';

export const Proposal = ({ title, name, description, image }) => {
  const textColor = useColorModeValue('gray.700', 'white');

  return (
    <Card minHeight="290.5px" p="1.2rem">
      <Box w="100%">
        <Flex flexDirection="column" w="100%">
          <Flex flexDirection="column" h="100%" lineHeight="1.6">
            <Text fontSize="sm" color="gray.400" fontWeight="bold">
              {title}
            </Text>
            <Text fontSize="lg" color={textColor} fontWeight="bold" pb=".5rem">
              {name}
            </Text>
            <Text
              fontSize="sm"
              color="gray.400"
              fontWeight="normal"
              noOfLines={3}
            >
              {description}
            </Text>
            <Spacer />
            <Flex align="center">
              <Button p="0px" variant="no-hover" bg="transparent">
                <Text
                  fontSize="sm"
                  color={textColor}
                  fontWeight="bold"
                  cursor="pointer"
                  transition="all .5s ease"
                  my={{ sm: '1.5rem', lg: '0px' }}
                  _hover={{ me: '4px' }}
                >
                  Read more
                </Text>
                <Icon
                  as={BsArrowRight}
                  w="20px"
                  h="20px"
                  fontSize="2xl"
                  transition="all .5s ease"
                  mx=".3rem"
                  cursor="pointer"
                  pt="4px"
                  _hover={{ transform: 'translateX(20%)' }}
                />
              </Button>
            </Flex>
          </Flex>
        </Flex>
      </Box>
    </Card>
  );
};
