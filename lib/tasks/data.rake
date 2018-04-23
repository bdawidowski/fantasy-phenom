namespace :data do
  desc "Updating MLB Data Every 15 Minutes"
  task mlb: :environment do
    GetMlbData.new
    puts "MLB Data Updated! #{Time.now}"
  end
end