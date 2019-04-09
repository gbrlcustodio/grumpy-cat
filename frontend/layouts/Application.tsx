import { Toolbar, Typography } from '@material-ui/core';
import AppBar from '@material-ui/core/AppBar';
import { createStyles, withStyles, WithStyles } from '@material-ui/core/styles';
import React, { ReactNode } from 'react';

interface IProps extends WithStyles<typeof styles> {
  children: ReactNode;
}

const styles = createStyles({
  content: {
    padding: '1rem',
  },
});

const Application = ({ classes, children }: IProps) => {
  return (
    <main>
      <AppBar position="static">
        <Toolbar>
          <Typography variant="h6" color="inherit">
            Grumpy Cat
          </Typography>
        </Toolbar>
      </AppBar>
      <div className={classes.content}>{children}</div>
    </main>
  );
};

export default withStyles(styles)(Application);
