import React from 'react';
import PropTypes from 'prop-types';
import { makeStyles } from '@material-ui/core/styles';
import Toolbar from '@material-ui/core/Toolbar';
import Button from '@material-ui/core/Button';
import IconButton from '@material-ui/core/IconButton';
import SearchIcon from '@material-ui/icons/Search';
import Typography from '@material-ui/core/Typography';
import Link from '@material-ui/core/Link';
import { Link as ReactLink } from 'react-router-dom';

const sections = [
  { title: 'Articles', url: '#' },
  { title: 'Exchange Rates', url: '#' },
  { title: 'Rate Hunter', url: '#' },
  { title: 'Policies', url: '#' },
  { title: 'About', url: '#' },
  { title: 'Contact Us', url: '#' }
];

const useStyles = makeStyles((theme) => ({
  toolbar: {
    borderBottom: `1px solid ${theme.palette.divider}`,
  },
  toolbarTitle: {
    flex: 1,
  },
  toolbarSecondary: {
    justifyContent: 'space-between',
    overflowX: 'auto',
  },
  toolbarLink: {
    padding: theme.spacing(1),
    flexShrink: 0,
  },
}));

export default function Header() {
  const classes = useStyles();

  return (
      <React.Fragment>
        <Toolbar className={classes.toolbar}>
          <Button size="small" href="https://github.com/erkizie" target="_blank">Subscribe</Button>
          <Typography
              component="h2"
              variant="h5"
              color="inherit"
              align="center"
              noWrap
              className={classes.toolbarTitle}
          >
            BINATION
          </Typography>
          <IconButton>
            <SearchIcon />
          </IconButton>
          <Button variant="outlined" size="small">
            <ReactLink to="/sign_up">
              Sign up
            </ReactLink>
          </Button>
        </Toolbar>
        <Toolbar component="nav" variant="dense" className={classes.toolbarSecondary}>
          {sections.map((section) => (
              <Link
                  color="inherit"
                  noWrap
                  key={section.title}
                  variant="body2"
                  href={section.url}
                  className={classes.toolbarLink}
              >
                {section.title}
              </Link>
          ))}
        </Toolbar>
      </React.Fragment>
  );
}

Header.propTypes = {
  sections: PropTypes.array,
  title: PropTypes.string,
};