require 'spec_helper'

describe 'DB' do
  
    before do
      #@dub = TM::DB.new
    end

    it "exists" do
      expect(TM::DB).to be_a(Class)
    end

    it "create_task method receives data and puts in SQL command" do
    
    end
    

end