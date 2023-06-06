import homePage from '../pages/homePage'

/** Access the root url. */
describe('main page sanity test', () => {
    it('validates the main page', () => {
        cy.visit('127.0.0.1:5000/')
        /** Assert title is visible. */
        cy.title()

        // views the experience details
        homePage.goToExperience();

        // Check resume page data is there
        cy.contains('Experience')
        cy.contains('QA Engineer')
        cy.contains('Testing Analyst')
        cy.contains('Automation Engineer')

        // Check links are navigational
        // skills
        homePage.goToSkills();
        cy.contains('Skills')

        // education
        homePage.goToEducation();
        cy.contains('Education')

        // about
        homePage.goToAbout()
        cy.contains('About')
    })
});