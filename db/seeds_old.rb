Gclass.create(:gclass => '6a')
Gclass.create(:gclass => '9b')
Gclass.create(:gclass => '7c')
Gclass.create(:gclass => '10a')
Subject.create(:subject => 'History')
Subject.create(:subject => 'Math')
Subject.create(:subject => 'Soft eng')
Subject.create(:subject => 'Geo')
Subject.create(:subject => 'Calculus')
Student.create(:name => 'Yura', :student_id =>'12345' ,:subject =>'Soft eng',:gclass=>'6a')
Student.create(:name => 'Yura', :student_id =>'12345' ,:subject =>'Math',:gclass=>'6a')
Student.create(:name => 'Yura', :student_id =>'12345' ,:subject =>'Geo',:gclass=>'6a')
Student.create(:name => 'Yura', :student_id =>'12345' ,:subject =>'Calculus',:gclass=>'6a')
Student.create(:name => 'Yura', :student_id =>'12345' ,:subject =>'History',:gclass=>'6a')
Student.create(:name => 'Vlad', :student_id =>'123456' ,:subject =>'Soft eng',:gclass=>'6a')
Student.create(:name => 'Vlad', :student_id =>'123456' ,:subject =>'Math',:gclass=>'6a')
Student.create(:name => 'Vlad', :student_id =>'123456' ,:subject =>'Geo',:gclass=>'6a')
Student.create(:name => 'Vlad', :student_id =>'123456' ,:subject =>'Calculus',:gclass=>'6a')
Student.create(:name => 'Vlad', :student_id =>'123456' ,:subject =>'History',:gclass=>'6a')
Student.create(:name => 'Dima', :student_id =>'1234567' ,:subject =>'Math',:gclass=>'7c')
Student.create(:name => 'Dima', :student_id =>'1234567' ,:subject =>'History',:gclass=>'7c')
Student.create(:name => 'Dima', :student_id =>'1234567' ,:subject =>'Calculus',:gclass=>'7c')
Student.create(:name => 'Dima', :student_id =>'1234567' ,:subject =>'Geo',:gclass=>'7c')
Student.create(:name => 'Alex', :student_id =>'123458' ,:subject =>'Geo',:gclass=>'7c')
Student.create(:name => 'Simon', :student_id =>'123459' ,:subject =>'Geo',:gclass=>'7c')
Student.create(:name => 'Kosty', :student_id =>'123450' ,:subject =>'Soft eng',:gclass=>'9b')
Student.create(:name => 'Liza', :student_id =>'123451' ,:subject =>'History',:gclass=>'10a')

Teacher.create(:name =>'Reuven1', :teacher_id=>'1234123', :subject => 'History', :gclass => '6a', :password => '12345', :group => '1' )
Teacher.create(:name =>'Reuven1', :teacher_id=>'1234123', :subject => 'Soft eng', :gclass => '6a', :password => '12345', :group => '1' )
Teacher.create(:name =>'Reuven1', :teacher_id=>'1234123', :subject => 'Math', :gclass => '6a', :password => '12345', :group => '1' )
Teacher.create(:name =>'Aksman', :teacher_id=>'123', :subject => 'Calculus', :gclass => '6a', :password => '123', :group => '1' )
Teacher.create(:name =>'Reuven2', :teacher_id=>'2222222', :subject => 'Geo', :gclass => '7c', :password => '12345', :group => '1' )
Teacher.create(:name =>'Aksman', :teacher_id=>'123', :subject => 'Calculus', :gclass => '6a7c', :password => '123', :group => '2' )
