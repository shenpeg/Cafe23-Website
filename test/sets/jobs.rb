module Contexts
  module Jobs

    def create_jobs
      @cashier = FactoryBot.create(:job)
      @barista = FactoryBot.create(:job, name: "Barista", description: "Making drinks for customers")
      @baking = FactoryBot.create(:job, name: "Baking", description: "Baking treats for customers")
      @mover = FactoryBot.create(:job, name: "Mover", active: false, description: "Moving stuff")
    end
    
    def destroy_jobs
      @cashier.destroy
      @barista.destroy
      @baking.destroy
      @mover.destroy
    end

  end
end