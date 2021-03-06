Feature: Manager want to see grades of student
AS A usual Manager at end of learning year
I WANT To search for student by his ID
SO That I can print his the diplom

Background: Data has been added to database
  Given I am on the home page
  And I fill in "user" with "123"
  And I fill in "Password" with "123"
  And I press "Login"

Scenario: Looking for existing student
  Given I fill in "student_id" with "876"
  When I press "Show Diplom"
  Then I should see "Grades table of Student BCE"
  And I should see "excellent work"
  
Scenario: Looking for not existing student
  When I fill in "student_id" with "8766"
  And I press "Show Diplom"
  Then I should see "Student with id 8766 not found"
  And I should be on the manager's options page
