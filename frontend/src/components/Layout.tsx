import { Box, Button, Flex, Stack, Text } from '@chakra-ui/react';
import React, { FC } from 'react';
import { Link } from 'react-router-dom';

const Layout: FC = ({ children }) => {
  return (
    <Stack h="100vh">
      <Flex
        bg="purple.200"
        p={4}
        justifyContent="space-around"
        alignContent="center"
      >
        <Box>
          <Text fontWeight="bold">joy Animals</Text>
        </Box>
        <Link to="/">
          <Button size="sm" colorScheme="blue">
            Main
          </Button>
        </Link>
        <Link to="/my-animal">
          <Button size="sm" colorScheme="red">
            My Animal
          </Button>
        </Link>
      </Flex>
      <Flex
        direction="column"
        h="full"
        justifyContent="center"
        alignContent="center"
      >
        {children}
      </Flex>
    </Stack>
  );
};

export default Layout;
