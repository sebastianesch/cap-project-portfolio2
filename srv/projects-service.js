const cds = require('@sap/cds')
const log = cds.log('projects-service')

class ProjectsService extends cds.ApplicationService {
    
    init() {

        const { Projects } = cds.entities

        this.on('isStarted', async function onIsStarted(request) {
            log.info('on isStarted - request.data', request.data, 'request.params:', request.params)
            const project = await SELECT.one.from(Projects).where({ID: request.data.project })
            const result = Date.parse(project.startDate) < new Date()
            return request.reply(result)
        })

        this.on('endProject', async function onEndProject(request) {
            log.info('on endProject - request.data', request.data, 'request.params:', request.params)
            const updateCount = await UPDATE(Projects).set({endDate: request.timestamp}).where({ID: request.data.project})
            if (updateCount != 1) {
                return request.error('UNABLE_TO_END_PROJECT', [request.data.project])
            }
        })

        this.on('stop', 'Projects', async function onStopProjects(request) {
            log.info('on stop Projects - request.data', request.data, 'request.params:', request.params)
            const projectId = request.params[0].ID
            const endDate = request.data.endDate ? request.data.endDate : request.timestamp
            const result = await UPDATE(Projects).set({endDate: endDate }).where({ID: projectId})
            if (result != 1) {
                return request.error('UNABLE_TO_END_PROJECT', [request.data.project])
            }
        })

        this.on('hasStarted', 'Projects', async function onHasStartedProjects(request) {
            log.info('on hasStarted Projects - request.data', request.data, 'request.params:', request.params)
            const projectId = request.params[0].ID
            const project = await SELECT.one.from(Projects).where({ID: projectId })
            const result = Date.parse(project.startDate) < request.timestamp
            return request.reply(result)
        })

        this.on('hasEnded', 'Projects', async function onHasEndedProjects(request) {
            log.info('on hasEnded Projects - request.data', request.data, 'request.params:', request.params)
            const projectId = request.params[0].ID
            const project = await SELECT.one.from(Projects).where({ID: projectId })
            const result = project.endDate != undefined && Date.parse(project.endDate) < request.timestamp
            return request.reply(result)
        })

        // Default Handlers for Create, Read, Update and Delete have before, after and on handlers

        this.before('READ', 'Projects', async function beforeReadProjects(request) {
            log.info('before READ Projects - request.data:', request.data, '- request.params:', request.params)
        })

        this.on('READ', 'Projects', async function onReadProjects(request, next) {
            log.info('on READ Projects - request.data:', request.data, '- request.params:', request.params)
            return next() // delegate it back to the CAP default handler
        })

        this.after('READ', 'Projects', async function beforeReadProjects(results, request) {
            log.info('after READ Projects - request.data:', request.data, '- request.params:', request.params)
            log.info('got ', results.length, 'results')
        })

        return super.init()
    }

  }
  
  module.exports = ProjectsService