require "google/apis/sheets_v4"
require "googleauth"
require "googleauth/stores/file_token_store"
require "fileutils"

class GCloudService 

  OOB_URI = "urn:ietf:wg:oauth:2.0:oob".freeze
  APPLICATION_NAME = "Google Sheets API Ruby Quickstart".freeze
  CREDENTIALS_PATH = "credentials.json".freeze
  TOKEN_PATH = "token.yaml".freeze
  SCOPE = Google::Apis::SheetsV4::AUTH_SPREADSHEETS

  attr_accessor :service

  def init
    @service = Google::Apis::SheetsV4::SheetsService.new
    @service.client_options.application_name = APPLICATION_NAME
    @service.authorization = authorize
  end

  def authorize
    client_id = Google::Auth::ClientId.from_file CREDENTIALS_PATH
    token_store = Google::Auth::Stores::FileTokenStore.new file: TOKEN_PATH
    authorizer = Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
    user_id = "default"
    credentials = authorizer.get_credentials user_id
    if credentials.nil?
      url = authorizer.get_authorization_url base_url: OOB_URI
      puts "Open the following URL in the browser and enter the " \
           "resulting code after authorization:\n" + url
      code = gets
      credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code, base_url: OOB_URI
      )
    end
    credentials
  end

  def read_spreadsheet(spreadsheet_id)
    range = "engenharia_de_software!A4:H"
    @service.get_spreadsheet_values spreadsheet_id, range
  end

  def write_spreadsheet(student, range_name, spreadsheet_id)
    values = [
      [student.situation, student.examGrade]
    ]
  
    data = [
      {range:  range_name, values: values}
    ]
  
    value_range_object = Google::Apis::SheetsV4::ValueRange.new(range:  range_name, values: values)
    result = service.update_spreadsheet_value(spreadsheet_id,
                                              range_name,
                                              value_range_object,
                                              value_input_option: "USER_ENTERED")                                       
  end
end