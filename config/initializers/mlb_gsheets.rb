require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'


class GetMlbData
  def initialize(spreadsheet_id)
    oob_url = 'urn:ietf:wg:oauth:2.0:oob'
    application_name = 'FP365'
    credentials_path = File.join(Dir.home, '.credentials', "sheets.googleapis.com-ruby-quickstart.yaml")
    scope = Google::Apis::SheetsV4::AUTH_SPREADSHEETS_READONLY
    FileUtils.mkdir_p(File.dirname(credentials_path))

    client_id = Google::Auth::ClientId.from_hash(JSON.parse(Rails.application.secrets.google_sheets_secret))
    token_store = Google::Auth::Stores::FileTokenStore.new(file: credentials_path)
    authorizer = Google::Auth::UserAuthorizer.new(
        client_id, scope, token_store)

    user_id = 'default'
    credentials = authorizer.get_credentials(user_id)
    # Initialize the API
    service = Google::Apis::SheetsV4::SheetsService.new
    service.client_options.application_name = application_name
    service.authorization = credentials
    @service = service
    fetchMlb(spreadsheet_id)
  end
  def fetchMlb(spreadsheet_id)
    MlbGame.delete_all
    base = 1
    while base > 0
      range = "API!A#{base}:Q#{base + 29}"
      result = @service.get_spreadsheet_values(spreadsheet_id, range)
      if result.values
        MlbGame.create(parseMlbResults(result.values))
        base += 29
      else
        base = 0
      end
    end
  end
  def parseMlbResults(response)
    game = {
        :away_team => response[0][1],
        :home_team => response[0][2],
        :degree => response[0][3],
        :weather => response[0][4],
        :wind => response[0][5],
        :away_money_line => response[0][6],
        :home_money_line => response[0][7],
        :away_bet => response[0][8],
        :home_bet => response[0][9],
        :team_batting_r => response[1][1..12],
        :team_batting_l => response[2][1..12],
        :team_batting_h => response[3][1..12],
        :team_batting_a => response[4][1..12],
        :pitcher_away => response[5][1..4],
        :pitcher_home => response[5][5..8],
        :pitcher_left => response[6][1..14],
        :pitcher_right => response[7][1..14],
        :pitcher_road => response[8][1..14],
        :pitcher_30days => response[9][1..14],
        :pitcher_2017 => response[10][1..14],
        :away_batters => [],
        :home_batters => []
    }
    (11..19).each do |i|
      game[:away_batters] << response[i][1..16]
    end
    (20..28).each do |i|
      game[:home_batters] << response[i][1..16]
    end
    return game
  end




end