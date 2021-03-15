class Student

    def exist? (registry)
        registry != nil && registry != ""
    end

    def attendance? (missedClasses)
        missedClasses <= 15
    end

    def grade (grade1, grade2, grade3)
        (p1+p2+p3) / 3
    end

    def necessaryGrade (grade)
        100-grade
    end

end

student = Student.new

#interação com csv/google docs
registry = 1
missedClasses = 8
grade1 = 35
grade2 = 63
grade3 = 61

if student.attendance?(missedClasses)

    grade = student.grade(grade1,grade2,grade3)

    if grade >= 70
        situation = "Aprovado"
        examGrade = 0

    elsif grade < 50
        situation = "Reprovado"
        examGrade = 0
        
    else
        situation = "Exame Final"
        examGrade = student.necessaryGrade(grade)
    end
end

puts "#{registry}:#{missedClasses}:#{grade1}:#{grade2}:#{grade3}:#{situation}:#{examGrade}"








