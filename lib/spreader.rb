# Thanks to the example set at https://github.com/xml4r/libxml-ruby/wiki/Using-the-Reader-API
# http://snippets.dzone.com/posts/show/5051
# http://www.informit.com/articles/article.aspx?p=683059&seqNum=18
# http://www.ruby-doc.org/docs/ProgrammingRuby/html/tut_modules.html
# http://xml4r.github.com/libxml-ruby/rdoc/
# http://blog.codahale.com/2005/11/24/a-ruby-howto-writing-a-method-that-uses-code-blocks/
# http://libxml.rubyforge.org/svn/tags/REL_0_9_2/README
# http://guides.rubygems.org/make-your-own-gem/
# http://visual.merriam-webster.com/plants-gardening/gardening/seeding-planting-tools_2.php

class Spreader
  #require 'rubygems'
  require 'xml'

  def extract(nodes)
    return yield nodes
  end
  
  def transform(nodes, model_name, latitude_field_name, longitude_field_name)
    prev_name = ''
    seeds = ''
    # i = 0

    while nodes.read
      unless nodes.node_type == XML::Reader::TYPE_END_ELEMENT
        seeds << model_name + '.create(:' + longitude_field_name + ' => ' + nodes.value.to_s.split(',').first + ', ' + ':' + latitude_field_name + ' => ' + nodes.value.to_s.split(',')[1] + ")\n" if (prev_name == 'coordinates') 
        # seeds << 'thing_' + (i+=1).to_s + ":\n  lat: " + nodes.value.to_s.split(',')[1] + "\n  lng: " + nodes.value.to_s.split(',').first + "\n\n" if (prev_name == 'coordinates') 
        prev_name = nodes.name
      end
    end
    
    nodes.close
    # puts seeds.chop
    return seeds
  end
  
  def load(seeds)
    File.open('db/seeds.rb', 'w') {|f| f.write(seeds.chop)}
    # File.open('../test/fixtures/things.yml', 'w') {|f| f.write(seeds.chop.chop)}
    system('rake db:seed')
  end
  
  def transformLoad(nodes, model_name, latitude_field_name, longitude_field_name)
    load(transform(nodes, model_name, latitude_field_name, longitude_field_name))
  end
  
  def self.seed(filename, model_name, latitude_field_name, longitude_field_name)
    spreader = Spreader.new
    spreader.transformLoad(spreader.extract(filename){|nodes| XML::Reader.file("#{nodes}", :options => XML::Parser::Options::NOBLANKS | XML::Parser::Options::NOENT)}, model_name, latitude_field_name, longitude_field_name)
  end
end