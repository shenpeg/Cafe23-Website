module Contexts
  module Stores

    def create_stores
      @cmu = FactoryBot.create(:store)
      @oakland = FactoryBot.create(:store, name: "Oakland", phone: "412-268-8211")
      @hazelwood = FactoryBot.create(:store, name: "Hazelwood", active: false)
    end
    
    def destroy_stores
      @cmu.destroy
      @hazelwood.destroy
      @oakland.destroy
    end

  end
end