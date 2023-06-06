/** Access the root url. */
describe('on the main page', () => {
    it('goes to the main page', () => {
        cy.visit('127.0.0.1:5000')
        /** Neg test case: Attept to visit bad API link */
        /** Neg test case: verify bad API link returns error */
        // validates that an error occurs
        cy.request({url: '127.0.0.1:5000/resumee', failOnStatusCode: false}).its('status').should('equal', 404)        

        /** Navigates to the API */
        /** Check page data returns 200 code */
        // visits proper API link
        cy.request('127.0.0.1:5000/resume').should((response) => {
            expect(response.status).to.eq(200);
            });
        
            cy.request({method: "POST",  
            url: '127.0.0.1:5000/resumee', failOnStatusCode: false,                   
            headers: {
                "Authorization": "Bearer " + Cypress.env('RtmApiToken'),
                "content-type": "application/json",
                body: {
                "profile": {
                    "first_name": "Michael0", "last_name": "0Keil",
                    "contact": {"address_one": "Raleigh, SC", "address_two": null, "phone": "(917) 336-3654"},
                    "email": "w.michaelkeil0000000@gmail.com",
                    "description": "test"}
                }, 
            }}).its('status').should('equal', 404)     
    })
});