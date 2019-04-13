import TextField from '@material-ui/core/TextField';
import { FieldProps, FormikErrors } from 'formik';
import React from 'react';

interface IFormikProps extends FieldProps {
  className?: string;
}

function capitalizeFirstLetter(string?: string): string {
  return string !== undefined ? string.charAt(0).toUpperCase() + string.slice(1) : '';
}

function getFirstError(errors: string | FormikErrors<any> | undefined): string {
  if (typeof errors === 'string') {
    return errors;
  }

  if (Array.isArray(errors) && errors.length > 0) {
    return errors[0];
  }

  return '';
}

const FormikField = ({ field, form: { touched, errors }, ...props }: IFormikProps) => {
  const error = getFirstError(errors[field.name]);

  return (
    <>
      <TextField
        {...field}
        {...props}
        error={touched[field.name] && !!errors[field.name]}
        helperText={touched[field.name] && capitalizeFirstLetter(error)}
      />
    </>
  );
};

export default FormikField;
