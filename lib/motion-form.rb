require 'bubble-wrap/core'
require 'motion-require'

unless defined?(Motion::Project::Config)
  raise 'This file must be required within a RubyMotion project Rakefile.'
end

Motion::Require.all(Dir.glob(File.expand_path('../project/**/*.rb', __FILE__)))
