import defaultTheme from 'tailwindcss/defaultTheme';
import forms from '@tailwindcss/forms';

/** @type {import('tailwindcss').Config} */
export default {
    content: [
        './vendor/laravel/framework/src/Illuminate/Pagination/resources/views/*.blade.php',
        './storage/framework/views/*.php',
        './resources/views/**/*.blade.php',
    ],

    theme: {
        extend: {
            fontFamily: {
                sans: ['Inter', ...defaultTheme.fontFamily.sans],
                head: ['Poppins', ...defaultTheme.fontFamily.sans],
            },
            colors: {
                navy: {
                    950: '#060f24',
                    900: '#0a1b3d',
                    800: '#102a56',
                    700: '#163b72',
                    600: '#1b4e9b',
                },
                teal: {
                    500: '#17c3c9',
                    400: '#3dd9db',
                    300: '#8fece9',
                    100: '#e4faf9',
                },
                muted: {
                    DEFAULT: '#5b6b85',
                    soft: '#8593ab',
                },
            },
            borderRadius: {
                sm: '10px',
                md: '16px',
                lg: '24px',
            },
        },
    },

    plugins: [forms],
};
