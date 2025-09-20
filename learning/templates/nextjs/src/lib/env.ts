import { z } from 'zod';

// Define server-only variables
const serverSchema = z.object({
  DATABASE_URL: z.string().url().or(z.string().min(1)),
  NEXTAUTH_URL: z.string().url().optional(),
  NEXTAUTH_SECRET: z.string().min(1).optional(),
  ENABLE_EXPERIMENTAL: z.string().optional(),
  SENTRY_DSN: z.string().optional(),
  POSTHOG_KEY: z.string().optional(),
});

// Define public variables (must be prefixed with NEXT_PUBLIC_)
const clientSchema = z.object({
  NEXT_PUBLIC_APP_NAME: z.string().default('App'),
  NEXT_PUBLIC_API_URL: z.string().url().default('http://localhost:3000/api'),
});

const _server = serverSchema.safeParse(process.env);
if (!_server.success) {
  console.error('Invalid server env:', _server.error.flatten().fieldErrors);
  throw new Error('❌ Invalid server environment variables');
}

const _client = clientSchema.safeParse(process.env);
if (!_client.success) {
  console.error('Invalid client env:', _client.error.flatten().fieldErrors);
  throw new Error('❌ Invalid public environment variables');
}

export const env = {
  ..._server.data,
  ..._client.data,
};

