import AppBar from '@material-ui/core/AppBar';
import Button from '@material-ui/core/Button';
import { createStyles, withStyles, WithStyles } from '@material-ui/core/styles';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';
import React, { ReactNode } from 'react';

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
});

const Application = ({ classes, children }: IProps) => {
  return (
    <main>
      <AppBar position="static">
        <Toolbar>
          <Typography variant="h6" color="inherit" className={classes.grow}>
            Grumpy Cat
          </Typography>

          <Button variant="contained" color="secondary" href="/complaint">
            Complain
          </Button>
        </Toolbar>
      </AppBar>
      <div className={classes.content}>{children}</div>
    </main>
  );
};

export default withStyles(styles)(Application);
