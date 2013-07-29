# -*- encoding: utf-8 -*-
Gem::Specification.new do |spec|
  spec.name          = 'motion-form'
  spec.version       = '0.0.1'
  spec.authors       = ['Devon Blandin']
  spec.email         = ['dblandin@gmail.com']
  spec.description   = %q{RubyMotion Forms made easy.}
  spec.summary       = %q{Simple DSL for RubyMotion form creation}
  spec.homepage      = 'https://github.com/dblandin/motion-form'
  spec.license       = 'MIT'

  files = []
  files << 'README.md'
  files.concat(Dir.glob('lib/**/*.rb'))
  spec.files         = files
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'motion-keyboard-avoiding'
  spec.add_development_dependency 'rake'
end
