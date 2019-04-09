import FormControl from '@material-ui/core/FormControl';
import MenuItem from '@material-ui/core/MenuItem';
import { createStyles, withStyles, WithStyles } from '@material-ui/core/styles';
import TextField from '@material-ui/core/TextField';
import SelectField from 'components/SelectField';
import React, { useCallback, useReducer } from 'react';

interface IState {
  company_id: string;
  grouped_by: string;
  locale: string;
}

type Action =
  | { type: 'change_company'; company_id: string }
  | { type: 'change_grouping'; grouped_by: string };

const initialState: IState = {
  company_id: '',
  grouped_by: '',
  locale: '',
};

function reducer(state: IState, action: Action): IState {
  switch (action.type) {
    case 'change_company':
      return { ...state, company_id: action.company_id };
    case 'change_grouping':
      return { ...state, grouped_by: action.grouped_by };
    default:
      return state;
  }
}

interface IProps extends WithStyles<typeof styles> {}

const ComplaintsFilter = ({ classes }: IProps) => {
  const [state, dispatch] = useReducer(reducer, initialState);

  const handleChangeCompany = useCallback(
    (event: React.ChangeEvent<HTMLSelectElement>) => {
      dispatch({ type: 'change_company', company_id: event.target.value });
    },
    [state.company_id]
  );

  const handleChangeGrouping = useCallback(
    (event: React.ChangeEvent<HTMLSelectElement>) => {
      dispatch({
        type: 'change_grouping',
        grouped_by: event.target.value,
      });
    },
    [state.grouped_by]
  );

  return (
    <form className={classes.container}>
      <FormControl variant="outlined" className={classes.control}>
        <SelectField
          name="company_id"
          label="Company"
          value={state.company_id}
          onChange={handleChangeCompany}
        >
          <MenuItem value="">
            <em>None</em>
          </MenuItem>
        </SelectField>
      </FormControl>
      <FormControl variant="outlined" className={classes.control}>
        <SelectField
          name="grouped_by"
          label="Grouped by"
          value={state.grouped_by}
          onChange={handleChangeGrouping}
        >
          <MenuItem value="">
            <em>None</em>
          </MenuItem>
          <MenuItem value="country">Country</MenuItem>
          <MenuItem value="state">State</MenuItem>
          <MenuItem value="city">City</MenuItem>
        </SelectField>
      </FormControl>
      <FormControl variant="outlined" className={classes.control}>
        <TextField variant="outlined" value={state.locale} label="Locale" />
      </FormControl>
    </form>
  );
};

const styles = createStyles({
  container: {
    padding: '0.5rem',
    marginBottom: 10,
    display: 'flex',
    flexDirection: 'row',
    gap: '5px',
  },
  control: {
    minWidth: 150,
  },
});

export default withStyles(styles)(ComplaintsFilter);
