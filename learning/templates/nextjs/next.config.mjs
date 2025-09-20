/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,

  // Example: restrict ESLint to project dirs
  eslint: {
    dirs: ['pages', 'app', 'components', 'lib', 'src'],
  },

  // Example: security headers (adjust to your needs)
  async headers() {
    return [
      {
        source: '/(.*)',
        headers: [
          { key: 'X-Frame-Options', value: 'SAMEORIGIN' },
          { key: 'X-Content-Type-Options', value: 'nosniff' },
          { key: 'Referrer-Policy', value: 'strict-origin-when-cross-origin' },
          // Content-Security-Policy: add a real CSP before production
          // { key: 'Content-Security-Policy', value: "default-src 'self'" },
        ],
      },
    ];
  },

  // Example: images configuration (allow specific hosts)
  images: {
    remotePatterns: [
      // { protocol: 'https', hostname: 'images.example.com' },
    ],
  },

  // Example: redirects/rewrites
  async redirects() {
    return [
      // { source: '/docs', destination: '/docs/getting-started', permanent: false },
    ];
  },
  async rewrites() {
    return [
      // { source: '/api/:path*', destination: 'https://api.example.com/:path*' },
    ];
  },

  // For Docker deploys: bundle node_modules into standalone server
  // output: 'standalone',

  // Experimental flags (enable cautiously)
  // experimental: { typedRoutes: true },
};

export default nextConfig;

