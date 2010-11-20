require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'iconv'

module MR
  module DB
    
    class ImgImporter
      
      def import_all
        
        Movie.all(:conditions => ['img IS NULL']).each do |movie|
          print "Looking for: #{movie.name}..."
          agent = Mechanize.new
          agent.get 'http://www.themoviedb.org/'
          agent.page.forms.first['search'] = Iconv.conv('utf-8', 'iso-8859-1', movie.name)
          agent.page.forms.first.submit
        
          if agent.page.uri.to_s.index('/movie/')
            doc = Nokogiri::HTML(agent.page.body)
            movie.img = doc.css('div#leftCol img').first.attributes['src'].value
            movie.save
            puts 'ok'
          else
            
            agent.user_agent_alias = 'Mac Safari'
            agent.get "http://www.imdb.com/find?s=all&q=#{movie.name}"
            
            if agent.page.uri.to_s.index('/find?')
              doc = Nokogiri::HTML(agent.page.body)
              if doc.css('img[width="23"]').first
                movie.img = doc.css('img[width="23"]').first.attributes['src'].value.gsub('SY30_SX23', 'SY300_SX300')
                if movie.img != '/images/b.gif'
                  movie.save
                  puts 'ok'
                else
                  puts 'fail'
                end
              else
                puts 'fail'
              end
            elsif agent.page.uri.to_s.index('/title/')
              doc = Nokogiri::HTML(agent.page.body)
              movie.img = doc.css('#img_primary img').first.attributes['src'].value
              movie.save
              puts 'ok'
            else
              puts 'fail'
            end
          end
        end
      end
      
    end
    
  end
end