package org.stevegood.sk



import grails.test.mixin.*
import spock.lang.*

@TestFor(RaidManagerController)
@Mock(RaidManager)
class RaidManagerControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.raidManagerInstanceList
            model.raidManagerInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.raidManagerInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            def raidManager = new RaidManager()
            raidManager.validate()
            controller.save(raidManager)

        then:"The create view is rendered again with the correct model"
            model.raidManagerInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            raidManager = new RaidManager(params)

            controller.save(raidManager)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/raidManager/show/1'
            controller.flash.message != null
            RaidManager.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def raidManager = new RaidManager(params)
            controller.show(raidManager)

        then:"A model is populated containing the domain instance"
            model.raidManagerInstance == raidManager
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def raidManager = new RaidManager(params)
            controller.edit(raidManager)

        then:"A model is populated containing the domain instance"
            model.raidManagerInstance == raidManager
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            controller.update(null)

        then:"A 404 error is returned"
            status == 404

        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def raidManager = new RaidManager()
            raidManager.validate()
            controller.update(raidManager)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.raidManagerInstance == raidManager

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            raidManager = new RaidManager(params).save(flush: true)
            controller.update(raidManager)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/raidManager/show/$raidManager.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            controller.delete(null)

        then:"A 404 is returned"
            status == 404

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def raidManager = new RaidManager(params).save(flush: true)

        then:"It exists"
            RaidManager.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(raidManager)

        then:"The instance is deleted"
            RaidManager.count() == 0
            response.redirectedUrl == '/raidManager/index'
            flash.message != null
    }
}
