# TuntsCorp Internship Challenge (Ruby) - Leonardo Krambeck

This challenge gives you a Google Docs spreadsheet containing a table of students and it's name, classes attendance, grades, etc. It is asked to develop a program that get the data from the API, calculates the student averages and write on the spreadsheet their situation.

More in-depth info can be found on 'TuntsCorp Challenge.pdf'

# Getting Started

Run in your terminal the following steps:

    $ sudo apt-get install ruby-full
    $ gem install google-api-client

Open the [public spreadsheet](https://docs.google.com/spreadsheets/d/1a2n_Ej9-xJUOfWTY-Z8sU_RP2v5EP03K71Yj-cdo4q8/edit#gid=0) and download this repository. While inside the repository, run this command:

    $ ruby challenge.rb

# Documentation

I divided the project in two main archives (g_cloud_service.rb and challenge.rb). The first one containing the necessary methods to have acess to the Google Docs API and the latter contains the classes and methods to calculate the students data and run the API methods.

**g_cloud_service.rb** contains the following methods all within GCloudService class:
- init (initialize)
- authorize
- read_spreadsheet
- write_spreadsheet

**challenge.rb** contains two classes:
- Student: stores the student data and a method to build it.
- GradesProcessor: calculates the student's grades, attendance, etc.

and the execute method to run everything in the correct order.



