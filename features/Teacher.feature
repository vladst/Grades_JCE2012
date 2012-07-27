Feature: Teacher update grades
AS A Teacher
I WANT To update grades of some class
SO That I can add/edit grades of classes or/and sign a class as graduated

Background: Data has been added to database
  Given I am on the home page
  And I fill in "user" with "2345"
  And I fill in "Password" with "2345"
  And I press "Login"
  
Scenario: I update grades for class
  When I follow "History at class 7b"
  Then I should see "Listing students for class 7b History"
  Given I fill in "students_19_grade" with "54"
  And I fill in "students_19_note" with "bad!"
  When I press "submit"
  Then I should see "UPDATED"
  When I follow "History at class 7b"
  Then the "students_19_grade" field should contain "54"
  
Scenario: I mark class as graduated
  Given I am on teacher's choose classes page
  And I should see "History at class 7b" before "Classes which have grades"
  And I follow "History at class 7b"
  Given I should see "Listing students for class 7b History"
  When I check "submitted"
  And I press "submit"
  Then I should see "UPDATED"
  And I should see "Classes which have grades" before "History at class 7b"

Scenario: I UNmark class as graduated
  Given I am on teacher's choose classes page
  And I should see "Classes which have grades" before "History at class 8b"
  And I follow "History at class 8b"
  Given I should see "Listing students for class 8b History"
  When I uncheck "submitted"
  And I press "submit"
  Then I should see "UPDATED"
  And I should see "History at class 8b" before "Classes which have grades"
