require "./g_cloud_service.rb"

class Student
    attr_accessor :registry, :missedClasses, :grade1, :grade2, :grade3, :grade_average, :situation, :examGrade

    def build_student (row)
        @registry = row[0].to_i
        @missedClasses = row[2].to_i
        @grade1 = row[3].to_i
        @grade2 = row[4].to_i
        @grade3 = row[5].to_i
        puts "Student: #{row[1]}"
    end
end

class GradesProcessor
    def calculate_grades (student)
        if has_minimum_attendance?(student)
            grade_average(student)
        
            if student.grade_average >= 70
                student.situation = "Aprovado"
                student.examGrade = 0
            elsif student.grade_average < 50
                student.situation = "Reprovado"
                student.examGrade = 0
            else
                student.situation = "Exame Final"
                student.examGrade = necessary_grade(student)
            end
        else
            student.situation = "Reprovado por Falta"
            student.examGrade = 0
        end
    end        

    private 
    def has_minimum_attendance? (student)
        student.missedClasses <= 15
    end

    def grade_average (student)
        student.grade_average = (student.grade1 + student.grade2 + student.grade3) / 3
    end

    def necessary_grade (student)
        student.examGrade = 100 - student.grade_average
    end
end

def print_logs (student)
    puts "Attendance: #{60-student.missedClasses}/60 (#{(60-student.missedClasses)*100/60}%)"
    puts "Grade1: #{student.grade1}, Grade2: #{student.grade2}, Grade3: #{student.grade3}"
    puts "Average grade: #{student.grade_average}"
    puts "Situation: #{student.situation}"
end

def execute
    student = Student.new
    grades_processor = GradesProcessor.new
    
    cloud_service = GCloudService.new
    cloud_service.init
    
    spreadsheet_id = "1a2n_Ej9-xJUOfWTY-Z8sU_RP2v5EP03K71Yj-cdo4q8"
    
    puts "Reading spreadsheet..."
    if (response = cloud_service.read_spreadsheet(spreadsheet_id))
        puts "Done."
    else
        puts "Cannot read spreadsheet."
    end
    
    response.values.each_with_index do |row,index|
      range_name = "engenharia_de_software!G#{4+index}:H"
      student.build_student(row)
      grades_processor.calculate_grades(student)
      print_logs (student)
      cloud_service.write_spreadsheet(student,range_name, spreadsheet_id)
    end
end

execute