class Student

    attr_accessor :registry, :missedClasses, :grade1, :grade2, :grade3, :gradeAverage, :situation, :examGrade

    def getStudent (row)
        @registry = row[0].to_i
        @missedClasses = row[2].to_i
        @grade1 = row[3].to_i
        @grade2 = row[4].to_i
        @grade3 = row[5].to_i
    end

end

class GradesProcessor

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

require 'csv'
table = CSV.read("teste.csv")

# 0 = registry
# 2 = missedClasses
# 3 = grade1
# 4 = grade2
# 5 = grade3 
# 6 = situation
# 7 = examGrade

student.getStudent (table[0])

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

puts "#{student.registry},#{student.missedClasses},#{student.grade1},#{student.grade2},#{student.grade3},#{student.gradeAverage},#{student.situation},#{student.examGrade}"