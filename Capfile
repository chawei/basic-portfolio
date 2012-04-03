require "bundler/capistrano"

load 'deploy'

Dir['vendor/gems/*/recipes/*.rb','vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy' # remove this line to skip loading any of the default tasks

# Uncomment if you are using Rails' asset pipeline
# This needs to be at the end of the file
# load 'deploy/assets'