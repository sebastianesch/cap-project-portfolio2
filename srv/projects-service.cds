using { projectportfolio.db as db } from '../db/schema';

service ProjectsService {

    @odata.draft.enabled
    entity Projects as projection on db.Projects;
    @readonly entity Customers as projection on db.Customers;

}