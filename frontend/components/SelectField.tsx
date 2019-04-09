import InputLabel from '@material-ui/core/InputLabel';
import OutlinedInput from '@material-ui/core/OutlinedInput';
import Select, { SelectProps } from '@material-ui/core/Select';
import React, { useEffect, useRef, useState } from 'react';
import ReactDOM from 'react-dom';

interface IProps extends SelectProps {
  label: string;
}

const SelectField = ({ name, label, ...props }: IProps) => {
  const [labelWidth, setLabelWidth] = useState(68);
  const labelRef = useRef<HTMLLabelElement>(null);

  useEffect(() => {
    if (labelRef.current !== null) {
      const node = ReactDOM.findDOMNode(labelRef.current) as HTMLLabelElement | null;

      if (node !== null) {
        setLabelWidth(node.offsetWidth || 0);
      }
    }
  }, [labelRef]);

  return (
    <>
      <InputLabel htmlFor={name} ref={labelRef}>
        {label}
      </InputLabel>
      <Select {...props} input={<OutlinedInput name={name} id={name} labelWidth={labelWidth} />} />
    </>
  );
};

export default SelectField;
