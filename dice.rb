class TwentyDice
  def roll
    [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20].sample
  end
end

class SixDice
  def roll
    [1,2,3,4,5,6].sample
  end
end

class Player
  def initialize
    dice=TwentyDice.new
    @life=dice.roll + dice.roll + dice.roll + dice.roll + dice.roll
    @max_life = @life
    puts"player's life is #{@life}"
  end

  def life
    @life
  end

  def heal
    @life = @max_life
  end

  def injury(damage)
    @life -= damage
  end
end

class TwelveDice
  def roll
    [1,2,3,4,5,6,7,8,9,10,11,12].sample
  end
end

class Monster
  def initialize
    dice=TwelveDice.new
    @life=dice.roll+dice.roll+dice.roll
    puts "the monster's life is #{@life}"
  end

  def life
    @life
  end

  def injury(damage)
    @life -= damage
  end
end

class Boss < Monster
  def initialize
    @life=40
    puts 'you found a BOSS'
  end
end

class Battle
  def initialize(player)
    @player=player
    roll=TwentyDice.new.roll
    if roll<=4
      @monster=Boss.new
    else
      @monster=Monster.new
    end
    @game_over=false
  end

  def game_over?
    @game_over
  end

  def turn
    @monster.injury TwentyDice.new.roll
    if @monster.life <= 0
      puts 'Player wins!'
      @game_over = true
      return
    end
    @player.injury TwelveDice.new.roll
    if @player.life <= 0
      puts 'Player died!'
      @game_over = true
      exit
    end
    puts "Player has #{@player.life} life"
    puts "Monster has #{@monster.life} life"
    puts "...press enter to continue..."
    $stdin.gets
  end
end

class Shop
  def initialize(player)
    @player = player
  end

  def sleep_at_the_inn
    @player.heal
    puts "After a nice rest, player has #{@player.life} life"
  end
end

# Game starts here
player = Player.new

puts "Okay, player... are you ready?"
answer = $stdin.gets.chomp

if answer[0].downcase == 'y'
  puts 'Time to battle!'
else
  puts "I'll see you later!"
  exit
end

loop do
  # Battle 1
  battle = Battle.new(player)
  until battle.game_over?
    battle.turn
  end

  puts "Press enter for the next battle!"
  $stdin.gets

  # Battle 2
  battle = Battle.new(player)
  until battle.game_over?
    battle.turn
  end

  puts 'you see a shop. do you enter?'
  answer= $stdin.gets
  if answer[0].downcase == 'y'
    Shop.new(player).sleep_at_the_inn
  end
end
