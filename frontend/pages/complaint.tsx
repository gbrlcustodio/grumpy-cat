import Button from '@material-ui/core/Button';
import MenuItem from '@material-ui/core/MenuItem';
import Paper from '@material-ui/core/Paper';
import { createStyles, withStyles, WithStyles } from '@material-ui/core/styles';
import Typography from '@material-ui/core/Typography';
import FormikField from 'components/FormikField';
import { get, post } from 'endpoint';
import { Field, Form, Formik, FormikActions, FormikProps } from 'formik';
import { useCurrentPosition } from 'hooks/useCurrentPosition';
import ApplicationLayout from 'layouts/Application';
import Router from 'next/router';
import React, { useCallback, useEffect, useState } from 'react';
import * as yup from 'yup';

interface IProps extends WithStyles<typeof styles> {}

const initialValues = {
  title: '',
  description: '',
  company: '',
};

const schema = yup.object().shape({
  title: yup.string().required(),
  description: yup.string().required(),
  company: yup.string().required(),
});

type Fields = typeof initialValues;

const Complaint = ({ classes }: IProps) => {
  const location = useCurrentPosition();
  const [companies, setCompanies] = useState([]);

  const handleSubmit = useCallback(
    ({ title, description, company }: Fields, { setSubmitting }: FormikActions<Fields>) => {
      setSubmitting(true);

      post('/complaints', {
        complaint: {
          title,
          description,
          company_id: company,
          latitude: location.latitude,
          longitude: location.longitude,
        },
      })
        .then(() => Router.push('/'))
        .catch();
    },
    [location],
  );

  useEffect(() => {
    get('/companies')
      .then(({ data }) => setCompanies(data))
      .catch();
  }, []);

  return (
    <ApplicationLayout>
      <img src="/static/yoda.jpg" alt="yoda" className={classes.yoda} />
      <Paper className={classes.container}>
        {(location && (
          <Formik initialValues={initialValues} onSubmit={handleSubmit} validationSchema={schema}>
            {({ isSubmitting }: FormikProps<Fields>) => (
              <Form className={classes.form}>
                <Field component={FormikField} variant="outlined" label="Title" name="title" />
                <Field
                  component={FormikField}
                  variant="outlined"
                  label="Description"
                  name="description"
                  multiline
                />
                <Field
                  component={FormikField}
                  select
                  name="company"
                  label="Company"
                  variant="outlined"
                >
                  <MenuItem value="">
                    <em>None</em>
                  </MenuItem>
                  {companies &&
                    companies.map(({ id, name }) => (
                      <MenuItem key={id} value={id}>
                        {name}
                      </MenuItem>
                    ))}
                </Field>

                <Button
                  variant="contained"
                  type="submit"
                  color="primary"
                  className={classes.button}
                  disabled={isSubmitting}
                >
                  Submit
                </Button>
              </Form>
            )}
          </Formik>
        )) || (
          <Typography variant="h6" className={classes.loading}>
            Fetching your location
          </Typography>
        )}
      </Paper>
    </ApplicationLayout>
  );
};

const styles = createStyles({
  container: {
    width: '80%',
    maxWidth: 1000,
    margin: '20px auto',
  },
  form: {
    display: 'flex',
    flexDirection: 'column',
    gap: '1rem',
    padding: '1rem',
  },
  button: {
    marginTop: 20,
  },
  yoda: {
    height: 250,
    margin: '50px auto',
    display: 'block',
  },
  loading: {
    padding: 20,
    textAlign: 'center',
  },
});

export default withStyles(styles)(Complaint);
