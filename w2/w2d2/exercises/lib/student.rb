class Student
  attr_reader :first_name, :last_name
  attr_accessor :courses

  def initialize(first, last)
    @first_name = first
    @last_name = last
    @courses = []
  end

  def name
    [first_name, last_name].join(' ')
  end

  def enroll(course)
    # need this unless statement to keep 100% pass rate for student_spec
    unless @courses.include?(course)
      if conflict?(course)
        raise Exception.new("Cannot add course, conflict with schedule")
      else
        @courses << course
        course.add_student(self)
      end
    end
  end

  def course_load
    student_load = {}

    courses.each do |course|
      if student_load[course.department] == nil
        student_load[course.department] = course.credits
      else
        student_load[course.department] += course.credits
      end
    end

    student_load
  end

  def conflict?(new_course)
    @courses.each do |course|
      if course.conflicts_with?(new_course)
        return true
        break
      end
    end
    false
  end
end
