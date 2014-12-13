require 'set'

class Student
  
  def initialize(first_name, last_name)
    @first_name, @last_name = first_name, last_name
    @courses = Set.new
  end
  
  def name
    "#{@first_name} #{@last_name}"
  end
  
  def enroll(course)
    @courses.add(course)
    course.add_student(self) unless course.students.include?(self)
  end
  
  def course_load
    course_credits = Hash.new(0)
    @courses.each do |course|
      course_credits[course] += course.credits
    end
    course_credits
  end
  
  def courses
    @courses.to_a
  end
  
  def inspect
    "#{ name }, #{ courses }"
  end
  
end

class Course
  
  attr_reader :students, :credits
  
  def initialize(name, department, credits)
    @name, @department, @credits = name, department, credits
    @students = Set.new
  end
  
  def add_student(student)
    @students.add(student)
    student.enroll(self)
  end
  
  def inspect
    "#<#{@name}, #{@department}, #{@credits} credits>"
  end
  
end

if $PROGRAM_NAME == __FILE__
  student1 = Student.new("Ben", "Henderson")
  student2 = Student.new("Justin", "Farooq")
  
  course1 = Course.new("Physics", "Science", 2)
  course2 = Course.new("English", "Language", 1)
  course3 = Course.new("Chemistry", "Science", 1)
  
  student1.enroll(course1)
  student1.enroll(course2)
  student1.enroll(course3)
  
  course1.add_student(student2)
  course2.add_student(student2)

  p course1.students, course2.students
end
