require 'bubble-wrap/core'
require 'motion-require'

Motion::Require.all(Dir.glob(File.expand_path('../project/**/*.rb', __FILE__)))

