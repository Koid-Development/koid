/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      fontFamily: {
        Saira: ["Fira Mono", "monospace"],
        Dancing: ["M PLUS 1 Code", "monospace"],
      }
    },
  },
  plugins: [],
}

