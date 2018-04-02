require 'httparty'

class GetMlbData
  def initialize
    @base_url = "https://sheets.googleapis.com/v4/spreadsheets/#{Rails.application.secrets.google_sheets_id}/values/"
    @secret_key = Rails.application.secrets.google_sheets_secret
    fetchMlb
  end
  def fetchMlb
    MlbGame.delete_all

    range = "API!A1:Q30"
    result = HTTParty.get(@base_url + range + "?key=#{@secret_key}")
    MlbGame.create(parseMlbResults(result["values"])) if result["values"]

    base = 60
    while base > 0
      range = "API!A#{base}:Q#{base + 48}"
      result = HTTParty.get(@base_url + range + "?key=#{@secret_key}")
      if result["values"]
        MlbGame.create(parseMlbResults(result["values"])) if parseMlbResults(result["values"])
        base += 40
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
    counter = 0
    game.each do |key, value|
      if value.kind_of?(Array)
        value.each_with_index do |item, i|
          if item.kind_of?(Array)
            item.each_with_index do |inner, ii|
              if inner === '-'
                game[key][i][ii] = ''
                counter += 1
              end
            end
          elsif item === '-'
            game[key][i] = ''
            counter += 1
          end
        end
      end
    end
    if counter < 35
      return game
    else
      return false
    end
  end
end


# oob_url = 'urn:ietf:wg:oauth:2.0:oob'
# application_name = 'FP365'
# credentials_path = File.join(Dir.home, '.credentials', "sheets.googleapis.com-ruby-quickstart.yaml")
# scope = Google::Apis::SheetsV4::AUTH_SPREADSHEETS_READONLY
# FileUtils.mkdir_p(File.dirname(credentials_path))
#
# client_id = Google::Auth::ClientId.from_hash(JSON.parse(Rails.application.secrets.google_sheets_secret))
# token_store = Google::Auth::Stores::FileTokenStore.new(file: credentials_path)
# authorizer = Google::Auth::UserAuthorizer.new(
#     client_id, scope, token_store)
#
# user_id = 'default'
# credentials = authorizer.get_credentials(user_id)
#
# if credentials.nil?
#   url = authorizer.get_authorization_url(
#       base_url: oob_url)
#   puts "Open the following URL in the browser and enter the " +
#            "resulting code after authorization"
#   puts url
#   code = gets
#   credentials = authorizer.get_and_store_credentials_from_code(
#       user_id: user_id, code: code, base_url: oob_url)
# end
# credentials
# # Initialize the API
# service = Google::Apis::SheetsV4::SheetsService.new
# service.client_options.application_name = application_name
# service.authorization = credentials
# @service = service