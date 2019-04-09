import { ICompany } from './company';

export interface IComplaint {
  id: number;
  title: string;
  description: string;
  company: ICompany;
}
