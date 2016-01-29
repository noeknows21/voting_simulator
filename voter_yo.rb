class Voter < People

  attr_accessor :poli_or_voter_obj, :affiliation_obj

  def initialize(name, p_or_v, aff)
    @name_obj = name
    @poli_or_voter_obj = p_or_v
    @affiliation_obj = aff
  end


end
