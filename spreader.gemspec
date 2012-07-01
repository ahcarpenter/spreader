Gem::Specification.new do |s|
  s.name = 'spreader'
  s.version = '0.0.11'
  s.date = '2012-06-30'
  s.summary = 'Spreader provides database-agnostic methods for facilitating the injection of coordinates into a data store.'
  # s.description = ''
  s.authors = ''
  # s.email = ''
  s.files = ['lib/spreader.rb']
  s.homepage = 'http://github.com/ahcarpenter/spreader'
  s.add_runtime_dependency 'libxml-ruby'
  s.add_runtime_dependency 'rake'
end