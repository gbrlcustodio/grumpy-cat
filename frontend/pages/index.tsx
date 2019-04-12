import Paper from '@material-ui/core/Paper';
import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableHead from '@material-ui/core/TableHead';
import TableRow from '@material-ui/core/TableRow';
import ComplaintsFilter from 'components/ComplaintsFilter';
import { get } from 'endpoint';
import ApplicationLayout from 'layouts/Application';
import React, { useEffect, useState } from 'react';
import { IComplaint } from 'types/complaint';

const Complaints = () => {
  const [complaints, setComplaints] = useState<IComplaint[]>([]);

  useEffect(() => {
    get('complaints')
      .then(({ data }) => setComplaints(data))
      .catch(e => console.error(e));
  }, []);

  return (
    <ApplicationLayout>
      <Paper>
        <ComplaintsFilter />
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
            {complaints.map(complaint => (
              <TableRow key={complaint.id}>
                <TableCell>{complaint.title}</TableCell>
                <TableCell>{complaint.description}</TableCell>
                <TableCell>{complaint.company.name}</TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </Paper>
    </ApplicationLayout>
  );
};

export default Complaints;
