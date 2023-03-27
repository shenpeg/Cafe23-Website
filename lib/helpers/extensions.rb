module Extensions
  class String
    def capwords
      words = self.split() 
      revised = Array.new
      words.each { |word| revised << word.capitalize } 
      final = revised.join(" ")
    end
  end
end