class Student

    attr_accessor :registry, :missedClasses, :grade1, :grade2, :grade3, :gradeAverage, :situation, :examGrade

    def buildStudent (row)
        @registry = row[0].to_i
        @missedClasses = row[2].to_i
        @grade1 = row[3].to_i
        @grade2 = row[4].to_i
        @grade3 = row[5].to_i
    end

end

class GradesProcessor

    def run (student)

        if hasMinimumAttendance?(student)

            gradeAverage(student)
        
            if student.gradeAverage >= 70
                student.situation = "Aprovado"
                student.examGrade = 0
        
            elsif student.gradeAverage < 50
                student.situation = "Reprovado"
                student.examGrade = 0
                
            else
                student.situation = "Exame Final"
                student.examGrade = necessaryGrade(student)
            end
        
        else
        
            student.situation = "Reprovado por Falta"
            student.examGrade = 0
        
        end
        puts student.inspect
    end        

    private 
    def hasMinimumAttendance? (student)
        student.missedClasses <= 15
    end

    def gradeAverage (student)
        student.gradeAverage = (student.grade1 + student.grade2 + student.grade3) / 3
    end

    def necessaryGrade (student)
        student.examGrade = 100 - student.gradeAverage
    end

end