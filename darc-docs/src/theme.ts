import {extendTheme} from '@mui/joy/styles';

export const customTheme = extendTheme({
    colorSchemes: {
        light: {
            palette: {
                background: {
                    body: 'var(--joy-palette-neutral-50)',
                },
            },
        },
        dark: {
            palette: {
                neutral: {
                    outlinedBorder: 'var(--joy-palette-neutral-700)',
                },
            },
        },
    },
    components: {
        JoyAutocomplete: {
            styleOverrides: {
                root: {
                    boxShadow: 'var(--joy-shadow-xs)',
                },
            },
        },
        JoyButton: {
            styleOverrides: {
                root: {
                    boxShadow: 'var(--joy-shadow-xs)',
                    transition: 'all 0.2s ease-in-out',
                    '&:hover': {
                        transform: 'scale(1.05)',
                    },
                    '&:active': {
                        transform: 'scale(0.95)',
                    },
                },
            },
        },
        JoyInput: {
            styleOverrides: {
                root: {
                    boxShadow: 'var(--joy-shadow-xs)',
                },
            },
        },
        JoyTextarea: {
            styleOverrides: {
                root: {
                    boxShadow: 'var(--joy-shadow-xs)',
                },
            },
        },
        JoySelect: {
            styleOverrides: {
                root: {
                    boxShadow: 'var(--joy-shadow-xs)',
                },
            },
        },
    },
    fontFamily: {
        display: "'Inter', var(--joy-fontFamily-fallback)",
        body: "'Inter', var(--joy-fontFamily-fallback)",
    },
});
