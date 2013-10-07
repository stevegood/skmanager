package org.stevegood.game



import grails.test.mixin.*
import spock.lang.*

@TestFor(GameRoleController)
@Mock(GameRole)
class GameRoleControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.gameRoleInstanceList
            model.gameRoleInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.gameRoleInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            def gameRole = new GameRole()
            gameRole.validate()
            controller.save(gameRole)

        then:"The create view is rendered again with the correct model"
            model.gameRoleInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            gameRole = new GameRole(params)

            controller.save(gameRole)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/gameRole/show/1'
            controller.flash.message != null
            GameRole.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def gameRole = new GameRole(params)
            controller.show(gameRole)

        then:"A model is populated containing the domain instance"
            model.gameRoleInstance == gameRole
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def gameRole = new GameRole(params)
            controller.edit(gameRole)

        then:"A model is populated containing the domain instance"
            model.gameRoleInstance == gameRole
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            controller.update(null)

        then:"A 404 error is returned"
            status == 404

        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def gameRole = new GameRole()
            gameRole.validate()
            controller.update(gameRole)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.gameRoleInstance == gameRole

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            gameRole = new GameRole(params).save(flush: true)
            controller.update(gameRole)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/gameRole/show/$gameRole.id"
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
            def gameRole = new GameRole(params).save(flush: true)

        then:"It exists"
            GameRole.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(gameRole)

        then:"The instance is deleted"
            GameRole.count() == 0
            response.redirectedUrl == '/gameRole/index'
            flash.message != null
    }
}
