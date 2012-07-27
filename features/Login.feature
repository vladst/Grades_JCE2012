Feature: Login page
AS A Teacher/Manager
I WANT To have a login
SO That I can add/edit grades of classes or see another options

Background: movies have been added to database
  Given I am on the home page

Scenario: Teacher login
  Given I fill in "user" with "2345"
  And I fill in "Password" with "2345"
  And I press "Login"
  Then I should see "You logged in as Moshe Levy"
  And I should see "View Classes you teach"
  
Scenario: Manager login
  Given I fill in "user" with "123"
  And I fill in "Password" with "123"
  And I press "Login"
  Then I should see "You logged in as Aksman"
  And I should see "Manager's home page"
  
Scenario: Not correct credential was entered
  Given I fill in "user" with "123"
  And I fill in "Password" with "WRONG PASSWORD"
  And I press "Login"
  Then I should see "Pair of login and password not found"
  And I should not see "You logged in"
