module MR
  module DB
    
    class Tables
      
=begin
      movies(id, name, rating)
      categories(id, name)
      tags(id, name, relevance)
      movies_ratings(movie, vector)
      movies_tags(movie, vector)
      movies_categories(movie, vector)
      movies_similarities(movie1, movie2, users, tags, categories, final)
=end
      
      def self.drop_and_create
        # drop and create database tables
        begin
          Tables.drop
        rescue
        end
        Tables.create
      end
      
      def self.drop
        # drop tables
        begin
          ActiveRecord::Schema.define do
            drop_table :movies
            drop_table :categories
            drop_table :tags
            drop_table :movie_ratings
            drop_table :movie_tags
            drop_table :movie_categories
            drop_table :movies_similarities
          end
        rescue Mysql::Error => exc
        end
      end
      
      def self.create
        # create tables
        Tables.movies
        Tables.categories
        Tables.tags
        Tables.movie_ratings
        Tables.movie_tags
        Tables.movie_categories
        Tables.movies_similarities
      end
      
      private
      def self.movies
        ActiveRecord::Schema.define do
          create_table :movies do |t|
            t.integer :id
            t.string :name
            t.float :rating
            t.text :img
          end
        end
      end
      
      def self.categories
        ActiveRecord::Schema.define do
          create_table :categories do |t|
            t.integer :id
            t.string :name
          end
        end
      end
      
      def self.tags
        ActiveRecord::Schema.define do
          create_table :tags do |t|
            t.integer :id
            t.string :name
            t.float :relevance
          end
        end
      end
      
      def self.movie_ratings
        ActiveRecord::Schema.define do
          create_table :movie_ratings do |t|
            t.integer :movie_id
            t.integer :user_id
            t.integer :rating
          end
        end
      end
      
      def self.movie_tags
        ActiveRecord::Schema.define do
          create_table :movie_tags do |t|
            t.integer :movie_id
            t.integer :tag_id
          end
        end
      end
      
      def self.movie_categories
        ActiveRecord::Schema.define do
          create_table :movie_categories do |t|
            t.integer :movie_id
            t.integer :category_id
          end
        end
      end
      
      def self.movies_similarities
        ActiveRecord::Schema.define do
          create_table :movies_similarities do |t|
            t.integer :movie_id_1
            t.integer :movie_id_2
            t.float :users_ranking
            t.float :tags_ranking
            t.float :categories_ranking
            t.float :final_ranking
          end
        end
      end
      
    end
    
  end
end