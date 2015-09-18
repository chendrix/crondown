# require gems
require 'bundler'
Bundler.require

# set the pathname for the root of the app
require 'pathname'
APP_ROOT = Pathname.new(File.expand_path("../../", __FILE__))

# require the server
lib = File.expand_path("../../app", __FILE__)
$:.unshift(lib)

require 'crondown/server'

# configure Server settings
module Crondown
  class Server < Sinatra::Base
    set :method_override, true
    set :root, APP_ROOT.to_path
    set :views, File.join(Crondown::Server.root, "app", "views")
    set :public_folder, File.join(Crondown::Server.root, "app", "public")
    set :protection, :except => :frame_options
  end
end