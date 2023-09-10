/***
 * Custom types that should be configured by developer
 ***/

import { z } from 'zod';
import { GuildInfo } from './types';

export type CustomGuildInfo = GuildInfo & {};

/**
 * Define feature ids and it's option types
 */
export type CustomFeatures = {
  'welcome-message': WelcomeMessageFeature;
};

export type WelcomeMessageFeature = {
  channel?: string;
  message: string;
};
