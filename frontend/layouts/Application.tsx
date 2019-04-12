import AppBar from '@material-ui/core/AppBar';
import Button from '@material-ui/core/Button';
import { createStyles, withStyles, WithStyles } from '@material-ui/core/styles';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';
import Link from 'next/link';
import Router from 'next/router';
import React, { ReactNode, useCallback } from 'react';

interface IProps extends WithStyles<typeof styles> {
  children: ReactNode;
}

const styles = createStyles({
  content: {
    padding: '1rem',
  },
  grow: {
    flexGrow: 1,
  },
  anchor: {
    color: 'inherit',
    textDecoration: 'none',
  },
});

const Application = ({ classes, children }: IProps) => {
  const complaint = useCallback(() => {
    Router.push('/complaint').catch();
  }, []);

  return (
    <main>
      <AppBar position="static">
        <Toolbar>
          <Typography variant="h6" color="inherit" className={classes.grow}>
            <Link href="/">
              <a className={classes.anchor}>Grumpy Cat</a>
            </Link>
          </Typography>

          <Button variant="contained" color="secondary" onClick={complaint}>
            Complain
          </Button>
        </Toolbar>
      </AppBar>
      <div className={classes.content}>{children}</div>
    </main>
  );
};

export default withStyles(styles)(Application);
