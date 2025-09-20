/** Lint-staged config for JS/TS monorepos using pnpm */
export default {
  "**/*.{js,jsx,ts,tsx}": [
    "pnpm eslint --fix",
    "pnpm prettier --write"
  ],
  "**/*.{json,md,mdx,css,scss,html}": [
    "pnpm prettier --write"
  ]
};

