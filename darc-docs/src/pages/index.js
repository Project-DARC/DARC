import React from 'react';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import Layout from '@theme/Layout';
import {Box, Button, Card, Container, CssVarsProvider, Grid, Input, Sheet, Stack, styled, Typography} from "@mui/joy";
import {
    AiOutlineSafety,
    FaFileContract,
    FiCheck,
    FiChevronRight,
    FiCopy,
    GiChaingun,
    GoTelescope
} from "react-icons/all";
import {useCopyToClipboard} from "react-use";
import Link from "@docusaurus/Link";
import {customTheme} from "../theme";

// styled docusaurus link without underline and default color
const PlainLink = styled(Link)(({theme}) => ({
    textDecoration: 'none',
    '&:hover': {
        textDecoration: 'none',
        color: 'inherit',
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
            <Container maxWidth={"xl"} sx={{
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'space-between',
            }}>
                <Stack spacing={4}>
                    <Typography level={'display2'} lineHeight={1.2}>
                        <Typography component={'span'} color={'primary'}>
                            Decentralized
                        </Typography>
                        <br/> Autonomous <br/> Regulated Corporation
                    </Typography>

                    <Typography level={'h6'} fontSize={'lg'} sx={(theme) => ({
                        color: theme.vars.palette.text.tertiary
                    })}>
                        From accountability and transparency to innovative decision-making, DARC is <br/>
                        revolutionizing the way we approach corporate structures. Join the
                        movement <br/> and
                        discover
                        the power of decentralized autonomous corporations.
                    </Typography>


                    <Stack direction={{xs: 'column', sm: 'row'}} spacing={2}>
                        <Button size={'lg'} endDecorator={<FiChevronRight/>}
                                component={PlainLink} to={'/docs/Overview/'}
                                sx={{
                                    '&:hover': {
                                        color: 'var(--joy-palette-common-white, #FFF)',
                                    },
                                    maxWidth: '300px'
                                }}
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

                <Box sx={{display: {xs: 'none', xl: 'block'}}}>
                    <img src={'/img/header-img-1.png'} style={{
                        height: '600px',
                    }}/>
                </Box>

            </Container>
        </>
    );
}

const Footer = () => {
    return (
        <Box textAlign={'center'}>
            <Typography variant={'body2'} fontSize={'sm'}>
                © 2023 DARC. All rights reserved.
            </Typography>
        </Box>
    )
}

const featureCardData = [
    {
        title: 'Decentralization',
        description: 'Enjoy the benefits of a decentralized operating framework with DARC, eliminating intermediaries and increasing efficiency for businesses.',
        icon: <GiChaingun/>
    },
    {
        title: 'Transparency',
        description: 'DARC offers a transparent operating environment for businesses, providing greater trust and accountability for all parties involved.',
        icon: <GoTelescope/>
    },
    {
        title: 'Trustless Transactions',
        description: 'Experience a trustless environment for transactions with DARC, where parties can transact and interact with each other without the need for intermediaries or third parties.',
        icon: <AiOutlineSafety/>
    },
    {
        title: 'Smart Contracts',
        description: 'Automate business processes and reduce costs with DARC\'s smart contract technology, providing a more efficient and effective way of conducting business.',
        icon: <FaFileContract/>
    }
]

const featureCardData2 = [
    {
        title: 'Docs',
        description: 'Simplify your documentation process with Darc\'s user-friendly and efficient documentation tools.',
        to: '/docs/Overview/',
    },
    {
        title: 'Github',
        description: 'Darc\'s open and decentralized ecosystem empowers businesses with transparency, collaboration, and regulatory compliance.',
        to: 'https://github.com/project-darc/darc'
    }
]

export default function Home() {
    const {siteConfig} = useDocusaurusContext();
    return (

        <Layout
            title={`Hello from ${siteConfig.title}`}
            description="Description will go into a meta tag in <head />">
            <CssVarsProvider disableTransitionOnChange theme={customTheme}>
                <Box sx={{
                    background: 'linear-gradient(121deg, rgba(255,255,255,1) 0%, rgba(231,243,255,100) 25%, rgba(255,255,255,1) 40%, rgba(255,255,255,1) 100%)',
                }}>
                    <Stack spacing={{
                        xs: 2,
                        md: 12
                    }}>
                        <Box>
                            <HomepageHeader/>
                        </Box>


                        <Box>
                            <Container maxWidth={'xl'}>
                                <Box>
                                    <Typography level={'h2'}>
                                        Features of
                                        <Typography component={'span'} color={'primary'} ml={1}>
                                            DARC
                                        </Typography>
                                    </Typography>

                                    <Grid container spacing={2} mt={2} alignItems={'stretch'}>
                                        {featureCardData.map((item, index) => (
                                            <Grid xs={6} lg={3} key={index} minHeight={'100%'}>
                                                <Card variant={'soft'} sx={{height: '100%'}}>
                                                    <Stack spacing={1}>
                                                        <Typography level={'body1'} fontWeight={'bolder'}
                                                                    gap={1} display={'flex'}>
                                                            <Typography component={'span'} alignSelf={'center'}
                                                                        display={'flex'}
                                                                        color={'primary'}>
                                                                {item.icon}
                                                            </Typography> {item.title}
                                                        </Typography>
                                                        <Typography level={'body2'} fontSize={'sm'}
                                                                    fontWeight={'normal'}>
                                                            {item.description}
                                                        </Typography>
                                                    </Stack>
                                                </Card>
                                            </Grid>
                                        ))}
                                    </Grid>
                                </Box>
                            </Container>
                        </Box>

                        <Box>
                            <Container maxWidth={'xl'}>
                                <Grid container spacing={2} alignItems={'center'}>
                                    <Grid xs={12} md={6} lg={5}>
                                        <Box>
                                            <Typography level={'h2'} mt={5}>
                                                <Typography component={'span'} color={'primary'} mr={1}>
                                                    Accelerate
                                                </Typography>
                                                delivery <br/> of your corporation
                                            </Typography>

                                            <Typography level={'body1'} fontSize={'sm'} fontWeight={'normal'} mt={2}
                                                        sx={(theme) => ({
                                                            color: theme.vars.palette.text.tertiary
                                                        })}>
                                                Unlock the potential of Darc's tools within the DARC ecosystem,
                                                optimizing
                                                efficiency and compliance for blockchain-based businesses. Experience a
                                                streamlined
                                                approach to project delivery and take your business to the next level
                                                with
                                                Darc's
                                                innovative tools.
                                            </Typography>
                                        </Box>
                                    </Grid>

                                    <Grid xs={12} md={6} sx={(theme) => ({
                                        '& a': {
                                            textDecoration: 'none',
                                        },
                                    })}>
                                        <Box>
                                            <Grid container spacing={2} alignItems={'stretch'}>
                                                {featureCardData2.map((item, index) => (
                                                    <Grid xs={6} minHeight={'100%'}>
                                                        <Sheet variant={'outlined'}
                                                               sx={theme => ({
                                                                   p: 2,
                                                                   borderRadius: 20,
                                                                   height: '100%'
                                                               })}>
                                                            <Stack justifyContent={'space-between'} spacing={1}
                                                                   height={'100%'}>
                                                                <Link to={item.to}>
                                                                    <Stack spacing={1}>
                                                                        <Typography level={'body1'}
                                                                                    fontWeight={'bolder'}>
                                                                            {item.title}
                                                                        </Typography>
                                                                        <Typography level={'body2'} fontSize={'sm'}>
                                                                            {item.description}
                                                                        </Typography>
                                                                    </Stack>
                                                                </Link>
                                                                <Typography to={item.to} component={PlainLink}
                                                                            level={'body2'}
                                                                            fontSize={'sm'} color={'primary'}
                                                                            fontWeight={'bold'}>
                                                                    Learn more
                                                                </Typography>
                                                            </Stack>
                                                        </Sheet>
                                                    </Grid>
                                                ))}
                                            </Grid>
                                        </Box>
                                    </Grid>
                                </Grid>
                            </Container>
                        </Box>
                    </Stack>

                    <Box mt={10}>
                        <Container>
                            <Footer/>
                        </Container>
                    </Box>
                </Box>
            </CssVarsProvider>
        </Layout>

    );
}
