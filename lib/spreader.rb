# Thanks to the example set at https://github.com/xml4r/libxml-ruby/wiki/Using-the-Reader-API
# http://snippets.dzone.com/posts/show/5051
# http://www.informit.com/articles/article.aspx?p=683059&seqNum=18
# http://www.ruby-doc.org/docs/ProgrammingRuby/html/tut_modules.html
# http://xml4r.github.com/libxml-ruby/rdoc/
# http://blog.codahale.com/2005/11/24/a-ruby-howto-writing-a-method-that-uses-code-blocks/
# http://libxml.rubyforge.org/svn/tags/REL_0_9_2/README
# http://guides.rubygems.org/make-your-own-gem/
# http://visual.merriam-webster.com/plants-gardening/gardening/seeding-planting-tools_2.php
# http://stackoverflow.com/questions/2741260/can-ruby-access-output-from-shell-commands-as-it-appears
# http://www.wallpaperama.com/forums/how-to-count-the-number-of-lines-in-a-file-in-linux-shell-command-t1084.html

class Spreader
  #require 'rubygems'
  require 'xml'
  @xml = false

  def extract(data)
    return yield data
  end

  def xml?(relative_path)
    head = IO.popen('head -' + IO.popen("wc -l #{relative_path}").gets.split(' ').first + " #{relative_path}")
    while line = head.gets
      @xml = true if (line.include? '<') && !@xml
    end
    
    return @xml
  end
  
  def transform(data, model_name, latitude_field_name, longitude_field_name)
    seeds = ''
    if @xml
      prev_name = ''
      # i = 0
  
      while data.read
        unless data.node_type == XML::Reader::TYPE_END_ELEMENT
          seeds << model_name + '.create(:' + longitude_field_name + ' => ' + data.value.to_s.split(',').first + ', ' + ':' + latitude_field_name + ' => ' + data.value.to_s.split(',')[1] + ")\n" if (prev_name == 'coordinates') 
          # seeds << 'thing_' + (i+=1).to_s + ":\n  lat: " + nodes.value.to_s.split(',')[1] + "\n  lng: " + nodes.value.to_s.split(',').first + "\n\n" if (prev_name == 'coordinates') 
          prev_name = data.name
        end
      end
      # puts seeds.chop
    else
      data.each do |datum|
        seeds << model_name + '.create(:' + longitude_field_name + ' => ' + datum.split(',').first + ', ' + ':' + latitude_field_name + ' => ' + datum.split(',').last.chop + ")\n"
      end
    end
    
    data.close
    return seeds
  end
  
  def load(seeds)
    File.open('db/seeds.rb', 'w') {|f| f.write(seeds.chop)}
    # File.open('../test/fixtures/things.yml', 'w') {|f| f.write(seeds.chop.chop)}
    system('rake db:seed')
  end
  
  def transformLoad(data, model_name, latitude_field_name, longitude_field_name)
    load(transform(data, model_name, latitude_field_name, longitude_field_name))
  end
  
  def self.seed(relative_path, model_name, latitude_field_name, longitude_field_name)
    spreader = Spreader.new
    spreader.transformLoad(spreader.extract(relative_path){|data| XML::Reader.file("#{data}", :options => XML::Parser::Options::NOBLANKS | XML::Parser::Options::NOENT)}, model_name, latitude_field_name, longitude_field_name) if spreader.xml?(relative_path)
    spreader.transformLoad(spreader.extract(relative_path){|data| File.open("#{data}")}, model_name, latitude_field_name, longitude_field_name) if !spreader.xml?(relative_path)
  end
end