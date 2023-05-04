import React from 'react';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import Layout from '@theme/Layout';
import {Box, Button, Container, CssVarsProvider, Input, Stack, styled, Typography} from "@mui/joy";
import {FiCheck, FiChevronRight, FiCopy} from "react-icons/all";
import {useCopyToClipboard} from "react-use";
import Link from "@docusaurus/Link";

// styled docusaurus link without underline and default color
const PlainLink = styled(Link)(({theme}) => ({
    textDecoration: 'none',
    color: 'var(--joy-palette-primary-solidColor, #fff)',
    '&:hover': {
        textDecoration: 'none',
        color: 'var(--joy-palette-primary-solidColor, #fff)',
    }
}))

function HomepageHeader() {
    const {siteConfig} = useDocusaurusContext();
    const [text, setText] = React.useState('npm install darcjs ethers@5.7.2');
    const [state, copyToClipboard] = useCopyToClipboard();
    const [isCopy, setIsCopy] = React.useState(false);

    // When user copies to clipboard, show tooltip and closed after 1 second
    const handleCopy = () => {
        copyToClipboard(text);
        setIsCopy(true);
        setTimeout(() => {
            setIsCopy(false);
        }, 1000);
    }

    return (
        <>
            <Container maxWidth={"lg"} sx={{
                height: 'calc(100svh - 60px)',
                display: 'flex',
                alignItems: 'center',
            }}>
                <Box>
                    <Stack spacing={4}>
                        <Typography level={'display1'} lineHeight={1.2}>
                            <Typography component={'span'} color={'primary'}>
                                Decentralized
                            </Typography>
                            <br/> Autonomous <br/> Regulated Corporation
                        </Typography>

                        <Typography level={'h4'} sx={(theme) => ({
                            color: theme.vars.palette.text.tertiary
                        })}>
                            From accountability and transparency to innovative decision-making, DARC is <br/>
                            revolutionizing the way we approach corporate structures. Join the movement <br/> and
                            discover
                            the power of decentralized autonomous corporations.
                        </Typography>


                        <Stack direction={'row'} spacing={2}>
                            <Button size={'lg'} endDecorator={<FiChevronRight/>}
                                    component={PlainLink} to={'/docs/Overview/'}
                            >Get started</Button>
                            <Box sx={{
                                cursor: 'pointer',
                            }}>
                                <Box onClick={() => handleCopy()}>
                                    <Input
                                        sx={{
                                            width: '300px',
                                            '& .Joy-disabled, .MuiInput-endDecorator': {
                                                color: 'black',
                                            }
                                        }}
                                        disabled
                                        size={'lg'}
                                        endDecorator={isCopy ? <FiCheck/> : <FiCopy/>}
                                        placeholder={text}/>
                                </Box>
                            </Box>
                        </Stack>
                    </Stack>
                </Box>
            </Container>
        </>
    );
}

const Footer = () => {
    return (
        <Container>
            <Box textAlign={'center'}>
                <Typography variant={'body2'}>
                    © 2023 DARC. All rights reserved.
                </Typography>
            </Box>
        </Container>
    )
}

export default function Home() {
    const {siteConfig} = useDocusaurusContext();
    return (

        <Layout
            title={`Hello from ${siteConfig.title}`}
            description="Description will go into a meta tag in <head />">
            <CssVarsProvider>
                <HomepageHeader/>
                <Footer/>
            </CssVarsProvider>
        </Layout>

    );
}
