require 'optparse'

# Set default options
options = {
  migrations: true,
  maintenance: false,
  branch: "master",
  remote: "production"
}

# Interpret passed in options
OptionParser.new do |opts|
  # Usage instructions.  Access with the --help flag
  opts.banner = "Usage: ruby deploy_heroku.rb [options]"

  # Optional Argument
  # Determines whether to run migrations or not. Default: migrations run.
  opts.on("-n", "--no-migrations", "Don't run `heroku run rake db:migrate`. They run by default.") do |v|
    options[:migrations] = v.nil?
  end

  # Option Argument
  # Determines wheather to turn site maintenance on before running migrations.
  opts.on("-m", "--maintenance-mode", "Run `heroku maintenance:on --remote`. Doesn't run by default") do |v|
    options[:maintenance] = v unless v.nil?
  end

  # Optional Argument
  # Determines which branch to push to Heroku. Default: master
  opts.on("--branch [BRANCH]", String, "Select a branch to push. e.g. '-b feature_something' Default: master") do |v|
    options[:branch] = v unless v.nil?
  end

  # Optional Argument
  # Determines which remote to push to.  Default: production
  opts.on("--remote [REMOTE]", String, "Set the remote to push to. e.g. '-r staging' Default: production") do |v|
    options[:remote] = v unless v.nil?
  end
end.parse!

# Deploy Code
puts "****************************************************"
puts "1. Deploying Code to Heroku"
puts "****************************************************"
puts "Branch: #{options[:branch].upcase}"
puts "Remote: #{options[:remote].upcase}"
puts "Run Migrations? #{options[:migrations].to_s.upcase}"
puts "Turn on Maintenance mode? #{options[:maintenance].to_s.upcase}"
puts "****************************************************"

system "git push -f #{options[:remote]} #{options[:branch]}:master"

# Run migrations
if options[:migrations] == true
  puts "****************************************************"
  puts "2. Running Migrations"
  puts "****************************************************"

  puts "Creating database backup"
  system "heroku pg:backups capture --remote #{options[:remote]}"

  if options[:maintenance] == true
    puts "Turning Site maintenance mode on"
    system "heroku maintenance:on --remote #{options[:remote]}"
  end

  puts "Running migrations"
  system "heroku run rake db:migrate --remote #{options[:remote]}"

  if options[:maintenance] == true
    puts "Turning site maintenance mode off..."
    system "heroku maintenance:off --remote #{options[:remote]}"
  end
end

puts "  ___   _      ___   _      ___   _      ___   _      ___   _
 [(_)] |=|    [(_)] |=|    [(_)] |=|    [(_)] |=|    [(_)] |=|
  '-`  |_|     '-`  |_|     '-`  |_|     '-`  |_|     '-`  |_|
 /mmm/  /     /mmm/  /     /mmm/  /     /mmm/  /     /mmm/  /
       |____________|____________|____________|____________|
                             |            |            |
                         ___  \_      ___  \_      ___  \_
                        [(_)] |=|    [(_)] |=|    [(_)] |=|
                         '-`  |_|     '-`  |_|     '-`  |_|
                        /mmm/        /mmm/        /mmm/

 ___ _   _  ___ ___ ___  ___ ___ 
/ __| | | |/ __/ __/ _ \\/ __/ __|
\\__ \\ |_| | (_| (_|  __/\\__ \\__ \\
|___/\__,_\_|\\___\\___\\___||___/___/"
                                 
