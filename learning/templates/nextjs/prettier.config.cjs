/** Prettier config for JS/TS/React */
module.exports = {
  semi: true,
  singleQuote: true,
  trailingComma: 'all',
  printWidth: 100,
  tabWidth: 2,
  overrides: [
    {
      files: ['*.yml', '*.yaml'],
      options: { tabWidth: 2 },
    },
  ],
  // If you use Tailwind, uncomment:
  // plugins: [require('prettier-plugin-tailwindcss')],
};

