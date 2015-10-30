namespace :dev do

  task :bm_test1 do
    require 'benchmark'

    puts Benchmark.measure {
      10000.times do
        "a"*1_000_000
      end
    }
  end

  task :bm_test2 do
    require 'benchmark'
    arr = (1...100000).to_a
    Benchmark.bm do |x|
      x.report do
        puts arr.reduce{ |sum,i| sum+i }
      end
      x.report do
        result = 0
        arr.each do |i|
          result += i
        end
        puts result
      end

      x.report do
        puts (arr.first + arr.last) * arr.size / 2
      end
    end

  end

  task :regenerate_user_token => :environment do
    User.all.each do |u|
      puts "User: #{u.id}"
      u.authentication_token = Devise.friendly_token
      u.save
    end
  end

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
