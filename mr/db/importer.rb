module MR
  
  module DB
    
    class Importer
      
      def initialize(ml_path)
        @ml_path = ml_path
      end
      
      def run
        #
        # movies.dat
        #
        # TABLES
        # movies
        # categories
        # movie_categories
        #
        File.open("#{@ml_path}/movies.dat").each do |line|
          
          movie = Movie.new
          movie.id, movie.name, categories = line.gsub("\n",'').split('::')


          categories.split('|').each do |c|
            category = Category.find_by_name(c)
            if category.nil?
              category = Category.new(:name => c)
              category.save
            end
            
            MovieCategory.create(:movie => movie, :category => category)
            
          end
          
          movie.save
          
        end
        
        #
        # tags.dat 
        #
        # TABLES
        # tags
        # movie_tags
        #
        
        File.open("#{@ml_path}/tags.dat").each do |line|
          
          user_id, movie_id, tag_name, timestamp = line.gsub("\n",'').split('::')
                    
          unless movie_id.empty?
            
            tag = Tag.find_by_name(tag_name)
            if tag.nil?
              tag = Tag.new(:name => tag_name)
              tag.save
            end
            
            MovieTag.create(:movie_id => movie_id, :tag => tag)
            
          end
          
        end
        
        #
        # ratings.dat
        #
        # TABLES
        # movies_ratings
        #
        
        File.open("#{@ml_path}/ratings.dat").each do |line|
          
          user_id, movie_id, rating, timestamp = line.gsub("\n",'').split('::')
                    
          unless movie_id.empty?
            
            MovieRating.create(:movie_id => movie_id, :user_id => user_id, :rating => rating)
            
          end
          
        end
        
      end
      
    end
    
  end
  
end