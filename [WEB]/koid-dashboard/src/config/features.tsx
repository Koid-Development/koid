import { Icon } from '@chakra-ui/react';
import { BsMusicNoteBeamed } from 'react-icons/bs';
import { FaGamepad } from 'react-icons/fa';
import { IoHappy } from 'react-icons/io5';
import { MdAddReaction, MdMessage } from 'react-icons/md';
import { FeaturesConfig } from './types';
import { provider } from '@/config/translations/provider';
import { createI18n } from '@/utils/i18n';
import { useWelcomeMessageFeature } from './example/WelcomeMessageFeature';

/**
 * Support i18n (Localization)
 */
const { T } = createI18n(provider, {
  en: {
  },
  cn: {
  },
});

/**
 * Define information for each features
 *
 * There is an example:
 */
export const features: FeaturesConfig = {
  'welcome-message': {
    name: 'Welcome Message',
    description: 'Send message when user joined the server',
    icon: <Icon as={MdMessage} />,
    useRender: useWelcomeMessageFeature,
  }
};
