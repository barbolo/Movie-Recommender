require 'mr/mr'

time = Time.now
MR::AI::Similarities.new.rank_movies

puts "total time: #{Time.now - time} seconds"