import FormControl from '@material-ui/core/FormControl';
import Paper from '@material-ui/core/Paper';
import { createStyles, withStyles, WithStyles } from '@material-ui/core/styles';
import TextField from '@material-ui/core/TextField';
import SelectField from 'components/SelectField';
import ApplicationLayout from 'layouts/Application';
import React from 'react';

interface IProps extends WithStyles<typeof styles> {}

const Complaint = ({ classes }: IProps) => {
  return (
    <ApplicationLayout>
      <Paper className={classes.container}>
        <form className={classes.form}>
          <FormControl variant="outlined">
            <TextField variant="outlined" label="Title" name="title" />
          </FormControl>
          <FormControl variant="outlined">
            <TextField variant="outlined" label="Description" name="description" multiline />
          </FormControl>
          <FormControl variant="outlined">
            <SelectField name="company_id" label="Company" />
          </FormControl>
        </form>
      </Paper>
    </ApplicationLayout>
  );
};

const styles = createStyles({
  container: {
    width: '80%',
    margin: '20px auto',
  },
  form: {
    display: 'flex',
    flexDirection: 'column',
    gap: '5px',
    padding: '1rem',
  },
});

export default withStyles(styles)(Complaint);
