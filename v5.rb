#ascii art main greeting
require './creator_greeting.rb'
include CreatorGreeting
display_creator_greeting

#loads up ascii art greeting for premade game
require './greeting.rb'
include CoolGreeting

class World
  attr_accessor :world_party1, :world_party2, :world_aff1, :world_aff2,
  :world_aff3, :world_aff4, :world_aff5

  def initialize(party1 = "Trumparian Consortium", party2 = "Bless Up Party",
    aff1 = "New Era Scientific", aff2 = "6 Gods", aff3 = "License to Nil",
    aff4 = "Flippy Floppies", aff5 = "Trump fo' lyfers")

    @world_party1 = party1
    @world_party2 = party2
    @world_aff1 = aff1
    @world_aff2 = aff2
    @world_aff3 = aff3
    @world_aff4 = aff4
    @world_aff5 = aff5
  end
  #brings in the other classes
  require './people_v5.rb'
  require './voter_yo.rb'
  require './politician_v3.rb'
  require './small_world.rb'

  @@list = []

  ##used to puts a more concise list that only includes people's names
  # used by the update methods and the delete method
  def names_list
    @@list.each { |item|
      puts item.name_obj
    }
  end

  def world_aff_choices
    puts "Type 1 for " + @@created_world.world_aff1
    puts "Type 2 for " + @@created_world.world_aff2
    puts "Type 3 for " + @@created_world.world_aff3
    if @@created_world.class == World
      puts "Type 4 for " + @@created_world.world_aff4
      puts "Type 5 for " + @@created_world.world_aff5
    end
  end

  def done_message
    system "clear"
    puts "Done!\n"
  end

  def delete
    system "clear"
    if @@list == [] #puts error message if there is no one to delete
      puts "No one to delete!"
      puts
      puts "Press enter to return to the main menu"
      gets
      system "clear"
      main_menu #returns user to main menu since there is no one to delete
    else
      system "clear"
      names_list
      puts
      puts "Which of these people would you like to delete?"
      name = gets.chomp
      hits = 0
      @@list.each {|item| #checks if the person exists and continues if so
        if item.name_obj == name
        system "clear"
        hits += 1
        puts "#{name} will be deleted. Are you (s)ure?" #asks user to confirm deletion
        delete_confirmation = gets.chomp.downcase
          if delete_confirmation == "s"
            @@list.delete_if {|element| element.name_obj == name}
            done_message
            main_menu
          else
            system "clear"
            puts "Deletion aborted. Returning to main menu."
            main_menu
          end
        end
      }
      if hits == 0
        puts "That person does not exist. Deletion aborted."
        puts "Press enter to return to the main menu"
        gets.chomp
        system "clear"
        main_menu
      end
    end
  end

  #final step of creation for politician. asks for the politician's party.
  def create_politician
    puts "What political party is this politician associated with?"
    puts "Type 1 for " + @@created_world.world_party1
    puts "Type 2 for " + @@created_world.world_party2
    @party = gets.chomp
    if @party == "1"
      @party = @@created_world.world_party1
      @@list << Politician.new(@name, @poli_or_voter, @party)
      done_message
      main_menu
    elsif @party == "2"
      @party = @@created_world.world_party2
      @@list << Politician.new(@name, @poli_or_voter, @party)
      done_message
      main_menu
    else
      puts "Invalid response. Try again."
      create_politician
    end
  end

  #final step of creation for voter. asks for an affiliation.
  def create_voter
    puts
    puts "Which of the following groups is the voter associated with?"
    world_aff_choices
    voter_aff = gets.chomp
    case voter_aff
    when "1"
      @@list << Voter.new(@name, @poli_or_voter, @@created_world.world_aff1)
      done_message
      main_menu
    when "2"
      @@list << Voter.new(@name, @poli_or_voter, @@created_world.world_aff2)
      done_message
      main_menu
    when "3"
      @@list << Voter.new(@name, @poli_or_voter, @@created_world.world_aff3)
      done_message
      main_menu
    when "4"
      @@list << Voter.new(@name, @poli_or_voter, @@created_world.world_aff4)
      done_message
      main_menu
    when "5"
      @@list << Voter.new(@name, @poli_or_voter, @@created_world.world_aff5)
      done_message
      main_menu
    else
      puts
      puts "Invalid response, try again"
      create_voter
    end
  end

  ##script for creaton part 2, asks if person is to be a politician or voter and
  #continues on to the appropriate method
  def create_method_part2
    puts "Would you like to create a (P)olitician or a (V)oter"
    @poli_or_voter = gets.chomp.downcase
    if @poli_or_voter == "p"
      @poli_or_voter = "Politician"
      create_politician
    elsif @poli_or_voter == "v"
      @poli_or_voter = "Voter"
      create_voter
    else
      puts "Invalid response, try again"
      create_method_part2
    end
  end

  #first step for creation, checks if person already exists
  def create_method_part1
  puts "What will this person's name be?"
  @name = gets.chomp
    #returns to main menu if this person's name already exists
  @@list.each {|element|
    if element.name_obj == @name
      system "clear"
      puts "Sorry this person already exists, returning to main menu"
      main_menu
    end
  }
  create_method_part2
  end

  #shows the main list of people, including all their affiliations/attributes
  def show_list
    system "clear"
    puts "Nothing here!\n" if @@list == []
    @@list.each {|item|
      print item.name_obj + " " + item.poli_or_voter_obj + " "
      puts item.party_obj if item.poli_or_voter_obj == "Politician"
      puts item.affiliation_obj if item.poli_or_voter_obj == "Voter"
    }
    puts "\nWhen finished, press enter to return to the main menu"
    gets
    system "clear"
    main_menu
  end

  # the update method will lead here if the user chose to update a person's name
  def update_name
    puts "Ok what will #{@name}'s new name be?"
    new_name = gets.chomp
    @current.name_obj = new_name
    done_message
    main_menu
  end

  ##updates a voter's affiliation. the update method leads here if the user
  #chose to update a voter
  def update_voter
    puts "(P)olitics"
    update_v_reply = gets.chomp.downcase
    if update_v_reply == "p"
      puts "What is this voters new affiliation?"
      world_aff_choices
      change_voter_politics = gets.chomp
      case change_voter_politics
      when "1"
        @current.affiliation_obj = @@created_world.world_aff1
        done_message
        main_menu
      when "2"
        @current.affiliation_obj = @@created_world.world_aff2
        done_message
        main_menu
      when "3"
        @current.affiliation_obj = @@created_world.world_aff3
        done_message
        main_menu
      when "4"
        @current.affiliation_obj = @@created_world.world_aff4
        done_message
        main_menu
      when "5"
        @current.affiliation_obj = @@created_world.world_aff5
        done_message
        main_menu
      else
        puts
        puts "Invalid response, try again"
        update
      end
    elsif update_v_reply == "n"
      update_name
    else #returns user to the update script if he/she entered an invalid input
      puts
      puts "Invalid response, try again"
      update
    end
  end

  ##updates a politician's party. the update method leads here if the user
  #chose to update a politician
  def update_politician
    puts "(P)arty"
    update_p_reply = gets.chomp.downcase
    if update_p_reply == "p"
      system "clear"
      puts "What political party is this politician now associated with?"
      puts "Type 1 for " + @@created_world.world_party1
      puts "Type 2 for " + @@created_world.world_party2
      change_party_reply = gets.chomp
      if change_party_reply == "1"
        @current.party_obj = @@created_world.world_party1
        done_message
        main_menu
      elsif change_party_reply == "2"
        @current.party_obj = @@created_world.world_party2
        done_message
        main_menu
      else
        puts
        puts "Invalid response, try again"
        update
      end
    elsif update_p_reply == "n"
      update_name
    else #returns user to the update script if he/she entered an invalid input
      puts "Invalid response, try again"
      update
    end
  end

  #begins the update script (part 1). forks into other areas based on user response
  def update
    if @@list != []
      puts
      names_list
      puts
      puts "Which of these people would you like to update?"
      @name = gets.chomp
      #checks if person already exists and continues if he/she does
      @@list.each {|item|
        if item.name_obj == @name
          @current = item
          puts
          puts "What would you like to update about #{@name}?"
          print "(N)ame or "
          ## script continues on to different scenarios based on if the person
          # is a politician or voter
          update_politician if item.poli_or_voter_obj == "Politician"
          update_voter if item.poli_or_voter_obj == "Voter"
        end
      }
      #this will run if the person does not already exist
      puts
      puts "That person does not exist. Check for spelling and case sensitivity."
      puts "Returning to main menu"
      main_menu
    else
      system "clear"
      puts "No one to update!"
      puts "\nPress enter to return to the main menu."
      gets
      system "clear"
      main_menu
    end
  end

  def election_day_results
    vote_array = []
    winners = []
    @@election_politicians.each { |vote_count|
      vote_array << vote_count.vote
    }
    winning_votes = vote_array.max
    @@election_politicians.each { |duck|
      if duck.vote == winning_votes
        winners << duck
      end
    }
    number_of_winners = winners.count
    if number_of_winners != 1
      puts
      puts "Looks like there's a #{number_of_winners} way tie!"
      random_victor = winners.sample.name_obj
      puts "A massive civil unrest ensues. Faulty ballot machines may be"
      puts "the root of the error, a recount is to be performed by the government"
      puts "Recount in progress...please hold"
      sleep(1.5)
      puts "#{random_victor} is the winner!"
    else
      winning_name = winners[0].name_obj
      puts
      puts "AND THE WINNER IS... #{winning_name}! CONGRATS!!!"
    end
    exit
  end

  def election_day_vote_count
    @@election_voters.each { |voter|
      case voter.affiliation_obj
        #members of Apathy Crew do not show up to vote
      when @@created_world.world_aff1, @@created_world.world_aff4
        if @@bless_ups.count == 0
          xyz = @@trumparians.sample
          xyz.vote = xyz.vote + 1
        else
          holder = @@bless_ups.sample
          holder.vote = holder.vote + 1
        end
      when @@created_world.world_aff2, @@created_world.world_aff5
        if @@trumparians.count == 0
          holder = @@bless_ups.sample
          holder.vote = holder.vote + 1
        else
        xyz = @@trumparians.sample
        xyz.vote = xyz.vote + 1
        end
      else
      end
    }
    election_day_results
  end

  ##organizes politicians into separate arrays based on their party
  def election_poli_organize
    @@trumparians = []
    @@bless_ups = []
    @@election_politicians.each { |poli|
      if poli.party_obj == @@created_world.world_party1
        @@trumparians << poli
      elsif poli.party_obj == @@created_world.world_party2
        @@bless_ups << poli
      end
    }
    election_day_vote_count
  end

  def election_art
    puts
    puts "Let the voting begin!"
    puts "Results coming in a few seconds!"
    sleep(2)
    system "clear"
    puts "3"
    sleep(1)
    system "clear"
    puts "2"
    sleep(1)
    system "clear"
    puts "1"
    sleep(1)
    system "clear"
    election_poli_organize
  end

  def election_check_message
    system "clear"
    puts "Election day cannot happen until there is at least one voter and"
    puts "at least 2 politcians. Press enter to return to the main menu."
    gets
    system "clear"
    main_menu
  end

  ##this will count voters and politcians and will cancel election day unless
  #there is one of each
  def election_day_check
    @@election_voters = []
    @@election_politicians = []
    @@list.each {|peep|
      if peep.poli_or_voter_obj == "Voter"
        @@election_voters << peep
      elsif
        peep.poli_or_voter_obj == "Politician"
        @@election_politicians << peep
      end
    }
    if @@election_voters.count >= 1
      if @@election_politicians.count >= 2
        election_art
      else
        election_check_message
      end
    else
      election_check_message
    end

  end

  def main_menu
    puts
    main_menu_string = "MAIN MENU"
    puts main_menu_string.center(72, "-")
    puts
    puts "Would you like to (C)reate a person, show a (L)ist of all people and their"
    puts "affiliations, (U)pdate a person, (D)elete a person or begin (E)lection day?"
    main_menu_reply = gets.chomp.downcase
    case main_menu_reply
    when "c"
      create_method_part1
    when "l"
      show_list
    when  "u"
      update
    when  "d"
      delete
    when  "e"
      election_day_check
    # this else statement runs main_menu again if user gave an invalid input
    else
      puts
      puts "Invalid response, please select a valid option. C, L, U, D or E"
      main_menu
    end
  end

  def name_conflict
    puts "Existing name conflict. Your punishment = start over!"
    custom_creation
  end

  def custom_creation
    puts
    puts "Name your voter simulator"
    sim_name = gets.chomp.upcase
    puts "Name a custom political party (it can be anything, go crazy!)"
    party1 = gets.chomp
    puts "Name a second political party"
    party2 = gets.chomp
    if party1 == party2
      name_conflict
    end
    puts "Name a custom voter affiliation."
    puts "This group will always vote for a candidate from the first political party"
    aff1 = gets.chomp
    puts "Name a second voter affiliation"
    puts "This group will always vote for a candidate from the second political party"
    aff2 = gets.chomp
    if aff2 == aff1
      name_conflict
    end
    puts "Name a final voter affiliation"
    puts "(Voting habits of this group are unknown)"
    aff3 = gets.chomp
    case aff3
    when aff1
      name_conflict
    when aff2
      name_conflict
    end
    puts "Excellent. Press enter to begin your custom simulation."
    gets.chomp
    system "clear"
    puts "WELCOME TO #{sim_name}!"
    @@created_world = SmallWorld.new(party1, party2, aff1, aff2, aff3)
    @@created_world.main_menu
  end

  def create_or_premade
    puts
    puts "Would you like to (c)reate your own voting simulator or play a (p)remade one?"
    c_or_p_answer = gets.chomp.downcase
    if c_or_p_answer == "c"
      custom_creation
    elsif c_or_p_answer =="p"
      @@created_world = World.new
      system "clear"
      display_greeting
      @@created_world.main_menu
    else
      puts
      puts "Invalid response, try again."
      create_or_premade
    end
  end

end

#starts the game
World.new.create_or_premade
