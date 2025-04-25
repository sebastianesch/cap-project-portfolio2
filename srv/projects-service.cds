using { projectportfolio.db as db } from '../db/schema';

@(requires: ['User'])
service ProjectsService {

    @odata.draft.enabled
    entity Projects as projection on db.Projects actions {
        function hasStarted() returns Boolean;
        function hasEnded() returns Boolean;
        action stop(endDate : Date);
    };
    function isStarted(project: Projects:ID) returns Boolean;
    action endProject(project: Projects:ID); 
    @readonly entity Customers as projection on db.Customers;

}