class SmallWorld < World
  attr_accessor :world_party1, :world_party2, :world_aff1, :world_aff2, :world_aff3
  ###break it up
  def initialize(party1 = "Trumparian Consortium", party2 = "Bless Up Party", aff1 = "License to Nil", aff2 = "6 Gods", aff3 = "New Era Scientific")
    @world_party1 = party1
    @world_party2 = party2
    @world_aff1 = aff1
    @world_aff2 = aff2
    @world_aff3 = aff3
  end
end
