using { projectportfolio.db as db } from '../db/schema';

@(requires: ['CustomerAdmin'])
service CustomersService  {

    @odata.draft.enabled
    entity Customers as projection on db.Customers;
    @readonly entity Projects as projection on db.Projects;

}