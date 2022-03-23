import { Box } from '@chakra-ui/react';
import React, { FC } from 'react';

interface MyAnimalProps {
  account: string;
}
const MyAnimal: FC<MyAnimalProps> = ({ account }) => {
  return <Box>MY</Box>;
};

export default MyAnimal;
