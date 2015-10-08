namespace :dev do

  task :fetch_ubike => :environment do
    puts "fetching ubike"

    url = "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=ddb80380-f1b3-4f8e-8016-7ed9cba571d5"

    raw_content = RestClient.get(url)

    data = JSON.parse( raw_content )

    data["result"]["results"].each do |u|
      u = Ubike.find_by_ubike_id( u["_id"] )

      if u
        # maybe update it!
      else
        Ubike.create( :ubike_id => u["_id"], :name => u["sna"])
      end
    end

  end

end
