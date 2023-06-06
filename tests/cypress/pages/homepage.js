class homePage{


    elements ={
        skillsLink : () => cy.get('li.nav-item:nth-child(2) > a:nth-child(1)'),

        educationLink : () => cy.get('li.nav-item:nth-child(4) > a:nth-child(1)'),

        aboutLink : () => cy.get('li.nav-item:nth-child(1) > a:nth-child(1)'),

        experienceLink : () => cy.get('li.nav-item:nth-child(3) > a:nth-child(1)')
    }

    goToSkills(){
        this.elements.skillsLink().click();
    }

    goToEducation(){
        this.elements.educationLink().click();
    }

    goToAbout(){
        this.elements.aboutLink().click();
    }

    goToExperience(){
        this.elements.experienceLink().click();
    }
}


module.exports = new homePage();