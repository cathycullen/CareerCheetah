# CareerCheetah

## Inquiry Models
These models drive the data collection functionality of the application. They are used to drive the quiz that users complete.

### Program
A program is made up of multiple Phases (in order). Initially, we'll only have a single Program, the default Career Cheetah program.

### Phase
A Phase is made up of many Sections in a particular order.

### Section
Sections are comprised of a collection of Questions in a particular order.

### Question
A Question includes a prompt (text) and a number of ResponseOptions (in a particular order). Some questions will allow only a single ResponseOption, while others will allow muliples.

### ResponseOption
A ResponseOption includes the response text and an optional reference to a Factor

## Prediction Models
The prediction models describe the data that is used as the inputs to the prediction algorithm. As a User, the end result of preforming the quiz (see Inquiry Models) is a collection of SelectedFactors.

### Career
Careers are imported from the Onet database and include:

* onet_code (required)
* title (required)
* description (required)

### CareerFactorMappings
CareerFactorMapping is a join model between Careers and Factors. The mapping also includes a weight of how important a factor is to a specific career.

### Factor
A Factor is a characteristic used to predict appropriate career options for a particular user. It's factors that when chosen (or not) determine the output of the application. Factor properties include:

* slug
* description
* element_code (optional): This code is sourced from the government's Occupational Informational Network database

### FactorSelection
A FactorSelection is a join model that joins a User and Factor. By choosing responses that map to Factors, a FactorSelection record is created. FactorSelctions are the inputs to the prediction algorithm. The list of selected factors determine the outputs of the application. Properties include:

* user_id (required)
* factor_id (required)
* rank (optional)
