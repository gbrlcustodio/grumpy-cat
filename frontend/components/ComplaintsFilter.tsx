import Button from '@material-ui/core/Button';
import MenuItem from '@material-ui/core/MenuItem';
import { createStyles, withStyles, WithStyles } from '@material-ui/core/styles';
import classNames from 'classnames';
import { Field, Form, Formik, FormikActions, FormikProps } from 'formik';
import React, { useCallback } from 'react';
import { ICompany } from 'types/company';
import FormikField from './FormikField';

interface IProps extends WithStyles<typeof styles> {
  companies: ICompany[];
  onSubmit: (fields: Fields) => Promise<void>;
}

const initialValues = {
  company: '',
  grouping: '',
  locale: '',
};

type Fields = typeof initialValues;

const ComplaintsFilter = ({ companies, classes, onSubmit }: IProps) => {
  const handleSubmit = useCallback((field: Fields, { setSubmitting }: FormikActions<Fields>) => {
    setSubmitting(true);

    onSubmit(field)
      .then(() => setSubmitting(false))
      .catch();
  }, []);

  return (
    <Formik initialValues={initialValues} onSubmit={handleSubmit}>
      {({ isSubmitting, values }: FormikProps<Fields>) => (
        <Form className={classes.container}>
          <Field
            component={FormikField}
            select
            name="company"
            label="Company"
            className={classes.control}
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
          <Field
            component={FormikField}
            select
            name="grouping"
            label="Grouped by"
            className={classes.control}
            variant="outlined"
          >
            <MenuItem value="">
              <em>None</em>
            </MenuItem>
            <MenuItem value="country">Country</MenuItem>
            <MenuItem value="state">State</MenuItem>
            <MenuItem value="city">City</MenuItem>
          </Field>
          <Field
            component={FormikField}
            variant="outlined"
            name="locale"
            label="Locale"
            className={classNames(classes.control, classes.searchField)}
            disabled={!values.grouping}
          />
          <Button type="submit" className={classes.searchButton} disabled={isSubmitting}>
            SEARCH
          </Button>
        </Form>
      )}
    </Formik>
  );
};

const styles = createStyles({
  container: {
    padding: '1rem',
    marginBottom: 10,
    display: 'flex',
    flexDirection: 'row',
    gap: '1rem',
  },
  control: {
    minWidth: 150,
  },
  searchField: {
    width: '50%',
  },
  searchButton: {
    marginLeft: 'auto',
  },
});

export default withStyles(styles)(ComplaintsFilter);
