class Student

    attr_accessor :registry, :missedClasses, :grade1, :grade2, :grade3, :gradeAverage, :situation, :examGrade

end

class GradesProcessor

    def exist? (student)
        student.registry != nil && student.registry != ""
    end

    def attendance? (student)
        student.missedClasses <= 15
    end

    def gradeAverage (student)
        student.gradeAverage = (student.grade1 + student.grade2 + student.grade3) / 3
    end

    def necessaryGrade (student)
        student.examGrade = 100 - student.gradeAverage
    end

end

student = Student.new
processor = GradesProcessor.new

student.registry = 8
student.missedClasses = 10
student.grade1 = 53
student.grade2 = 96
student.grade3 = 89 

if processor.attendance?(student)

    processor.gradeAverage(student)

    if student.gradeAverage >= 70
        student.situation = "Aprovado"
        student.examGrade = 0

    elsif student.gradeAverage < 50
        student.situation = "Reprovado"
        student.examGrade = 0
        
    else
        student.situation = "Exame Final"
        student.examGrade = processor.necessaryGrade(student)
    end

else

    student.situation = "Reprovado por Falta"
    student.examGrade = 0

end

puts "#{student.registry}:#{student.missedClasses}:#{student.grade1}:#{student.grade2}:#{student.grade3}:#{student.gradeAverage}:#{student.situation}:#{student.examGrade}"