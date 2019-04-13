import Paper from '@material-ui/core/Paper';
import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableHead from '@material-ui/core/TableHead';
import TableRow from '@material-ui/core/TableRow';
import ComplaintsFilter from 'components/ComplaintsFilter';
import { get } from 'endpoint';
import ApplicationLayout from 'layouts/Application';
import React, { useCallback, useEffect, useState } from 'react';

const Complaints = () => {
  const [complaints, setComplaints] = useState([]);
  const [companies, setCompanies] = useState([]);
  const handleSubmitFilters = useCallback(async ({ company, grouping, locale }) => {
    await get(`/complaints?company_id=${company}&grouping=${grouping}&locale=${locale}`).then(
      ({ data }) => setComplaints(data),
    );
  }, []);

  useEffect(() => {
    get('/complaints')
      .then(({ data }) => setComplaints(data))
      .catch();
  }, []);

  useEffect(() => {
    get('/companies')
      .then(({ data }) => setCompanies(data))
      .catch();
  }, []);

  return (
    <ApplicationLayout>
      <Paper>
        <ComplaintsFilter companies={companies} onSubmit={handleSubmitFilters} />
      </Paper>
      <Paper>
        <Table>
          <TableHead>
            <TableRow>
              <TableCell>Title</TableCell>
              <TableCell>Description</TableCell>
              <TableCell>Company</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {complaints.map(({ id, title, description, company: { name } }) => (
              <TableRow key={id}>
                <TableCell>{title}</TableCell>
                <TableCell>{description}</TableCell>
                <TableCell>{name}</TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </Paper>
    </ApplicationLayout>
  );
};

export default Complaints;
