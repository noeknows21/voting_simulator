class Politician < People

attr_accessor :poli_or_voter_obj, :party_obj, :vote

def initialize(name, p_or_v, party, vote = 0)
  @name_obj = name
  @poli_or_voter_obj = p_or_v
  @party_obj = party
  @vote = 0
end

end
